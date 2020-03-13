extends KinematicBody2D

const GRAVITY = 10
# make speed edidable from inspector
export (int) var speed = 30
export (int) var health = 1
export (Vector2) var size = Vector2(1,1)
const FLOOR = Vector2(0, -1)
 
var velocity = Vector2(0,0)
# default direction is right which is 1
var direction = 1

var is_dead = false

func _ready():
	scale = size
	

func dead():
	health -= 1
	if health <= 0:
		
		is_dead = true
		# stop enemy movement
		velocity = Vector2(0, 0)
		# change enemy sprite
		$AnimatedSprite.play("death")
		# remove enemy collision box
		$CollisionShape2D.set_deferred("disabled", true)
		# let the body stay on stage for a few seconds
		if get_parent().get_parent().name == "StageOne":
			get_node("/root/GlobalVar").stageOnePoints += 1
		else:
			get_node("/root/GlobalVar").stageTwoPoints += 1
		$DeathTimer.start()
		# shake the screen if the dead enemy is large
		if scale > Vector2(1,1):
			# get_parent() grabs stageone
			# shake length, shake power, shake priority
			get_parent().get_parent().get_node("ScreenShake").screen_shake(1, 10, 100)

func _physics_process(delta):
	# run this physics if enemy isn't dead
	if not is_dead:
		velocity.x = speed * direction
		$AnimatedSprite.play("walk")
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
	
	# reverse direction of enemy if collided with wall
	if is_on_wall():
		# flip sprite direction
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		direction *= -1
		$RayCast2D.position.x *= -1
	# detect if the enemy is on a ledge
	if not $RayCast2D.is_colliding():
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		direction *= -1
		$RayCast2D.position.x *= -1
	
	# count collisions (walls or player) as a result of move_and_slide
	if get_slide_count() > 0:
		# grab each collision entity (wall or player)
		for i in range (get_slide_count()):
			# check is the collision is a player
			if "Player" in get_slide_collision(i).collider.name:
				# kill the player if the collision was an player
				get_slide_collision(i).collider.dead()
		

# remove the Enemy sprite after timeout
func _on_DeathTimer_timeout():
	
	self.queue_free()
	
