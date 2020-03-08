extends KinematicBody2D

# create a pair variable to hold location of player
var velocity = Vector2()
# constant variables
const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const FIREBALL = preload("res://Scenes/Fireball.tscn")

# top of the floor tile pixel
const FLOOR = Vector2(0, -1)

var on_ground = false
var is_attacking = false

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		
		if not is_attacking or not is_on_floor():
			velocity.x = SPEED
			
			if not is_attacking:
				# don't flip sprite when facing right
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("run")
				
				# make sure the fireball emission is at the correct direction
				if sign($FireballEmission2D.position.x) == -1:
					$FireballEmission2D.position.x *= -1
				# NOTE: center of Position2D is the center of Player spite
	elif Input.is_action_pressed("ui_left"):
		
		if not is_attacking or not is_on_floor():
			velocity.x = -SPEED
			
			if not is_attacking:
				# make sure the fireball emission is at the correct direction
				if sign($FireballEmission2D.position.x) == 1:
					$FireballEmission2D.position.x *= -1
				
				# flip sprite when facing left
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("run")
	else:
		# default: do not move x
		velocity.x = 0
		# play the idle animation only if player is not moving AND is on ground
		if on_ground and not is_attacking:
			$AnimatedSprite.play("idle")
	
	if Input.is_action_pressed("ui_up"):
		if not is_attacking:
			# only jump when on ground
			if on_ground == true:
				velocity.y = JUMP_POWER
				
				on_ground = false
	
	# bring the player down due to gravity
	velocity.y += GRAVITY
	
	# only fire fireball if the attack animation is finished
	if Input.is_action_just_pressed("ui_shoot") && not is_attacking:
		# no movement allowed when firing
		if is_on_floor():
			velocity.x = 0
		
		is_attacking = true
		$AnimatedSprite.play("attack")
		
		# ready the fireball node
		var fireball = FIREBALL.instance()
		
		if sign($FireballEmission2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		
		# add fireball to the StageOne scene
		self.get_parent().add_child(fireball)
		# make sure the fireball comes out of the static position box
		# aka in front of player
		fireball.position = $FireballEmission2D.global_position
	
	if is_on_floor():
		if not on_ground:
			# attacks are to be easily overridable by jump or other movement
			is_attacking = false
		on_ground = true
	else:
		if not is_attacking:
			on_ground = false
			# if player is moving upwards and isn't on ground, play jump animation
			if velocity.y < 0:
				$AnimatedSprite.play("jump")
			else:
				# if player is moving down and isn't on ground play fall animation
				$AnimatedSprite.play("fall")
	
	# move player according to updated vector
	velocity = move_and_slide(velocity, FLOOR)

# only allow the play to fire when the attack animation is done
func _on_AnimatedSprite_animation_finished():
	is_attacking = false
