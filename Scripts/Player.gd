extends KinematicBody2D

# create a pair variable to hold location of player
var velocity = Vector2()
# constant variables
const SPEED = 30
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0, -1)


func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		# default: do not move x
		velocity.x = 0
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
	else:
		# default: do not move y
		velocity.y = 0
	
	# move player according to updated vector
	move_and_slide(velocity)
