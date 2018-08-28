extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const WALK_SPEED = 200 
const JUMP_SPEED = 60
const JUMP_FRAMES = 50

var velocity = Vector2()
var jump_frames = 60


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.

	#linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)

	var target_dir = 0
	
	if Input.is_action_pressed("move_left"):
		target_dir += -1
		$AnimatedSprite.play("walk left")
		
	if Input.is_action_pressed("move_right"):
		target_dir +=  1
		$AnimatedSprite.play("walk right")
		
	if Input.is_action_pressed("jump"):
		if velocity.y == 0:
			jump_frames = JUMP_FRAMES
			velocity.y = -JUMP_SPEED
		
	if velocity.y != 0:
		jump_frames -= 1
		if jump_frames < 0:
			velocity.y = 0 
		if jump_frames<JUMP_FRAMES/2 && velocity.y<0:
			velocity.y = JUMP_SPEED
			
		
	velocity.x = target_dir * WALK_SPEED
	
	move_and_slide(velocity)

