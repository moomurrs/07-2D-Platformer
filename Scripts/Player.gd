extends KinematicBody2D

# create a pair variable to hold location of player
var velocity = Vector2()
# constant variables
const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250

# top of the floor tile pixel
const FLOOR = Vector2(0, -1)

var on_ground = false

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	else:
		# default: do not move x
		velocity.x = 0
		# play the idle animation only if player is not moving AND is on ground
		if on_ground:
			$AnimatedSprite.play("idle")
	
	if Input.is_action_pressed("ui_up"):
		
		# only jump when on ground
		if on_ground == true:
			velocity.y = JUMP_POWER
			
			on_ground = false
	
	# bring the player down due to gravity
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		# if player is moving upwards and isn't on ground, play jump animation
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			# if player is moving down and isn't on ground play fall animation
			$AnimatedSprite.play("fall")
	
	# move player according to updated vector
	velocity = move_and_slide(velocity, FLOOR)
