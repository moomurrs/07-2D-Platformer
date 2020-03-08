extends Area2D

const SPEED = 100
var velocity = Vector2()

# 1 is fireball is facing right and -1 left
var direction = 1

# flip the fireball direction horintally
func set_fireball_direction(dir):
	direction = dir

	# by default, the fireball faces right.
	# check if the fireball needs to face left
	if dir == -1:
		# make fireball face left
		$AnimatedSprite.flip_h = true

func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	# move the fireball (area2d)
	self.translate(velocity)
	$AnimatedSprite.play("shoot")

# when the fireball leaves the screen, destroy it
func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()

# destroy fireball when it encountes an object
func _on_Fireball_body_entered(body):
	# check is the fireball hit an enemy. if so, trigger its death
	if "Enemy" in body.name:
		body.dead()
	# remove fireball after collision
	self.queue_free()
