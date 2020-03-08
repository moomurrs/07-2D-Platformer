extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2(0,0)
# default direction is right which is 1
var direction = 1

var is_dead = false

func _ready():
	pass

func dead():
	is_dead = true
	# stop enemy movement
	velocity = Vector2(0, 0)
	# change enemy sprite
	$AnimatedSprite.play("death")
	# remove enemy collision box
	$CollisionShape2D.set_deferred("disabled", true)
	# let the body stay on stage for a few seconds
	$DeathTimer.start()

func _physics_process(delta):
	# run this physics if enemy isn't dead
	if not is_dead:
		velocity.x = SPEED * direction
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
		

# remove the Enemy sprite after timeout
func _on_DeathTimer_timeout():
	self.queue_free()
