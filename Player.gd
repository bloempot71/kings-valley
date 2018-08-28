extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const FLOOR_NORMAL = Vector2(0, -1)
const WALK_SPEED = 200 
const FALL_SPEED = 60
const JUMP_SPEED = 60
const JUMP_FRAMES = 50

var velocity = Vector2()
var jump_frames = 60
var jumping = false
var last_dir = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.

	if velocity.y == 0:
		#if is_colliding():
		#	print("Collision with ", get_collider() )
		#velocity.y += FALL_SPEED # gravity
		
		#var d  = move_and_slide(velocity)
		#if d != null:
		#	print("We are colliding with", d)
		#	velocity.y = 0
		#if is_on_floor()
		#velocity.y = 0 
		pass

	var target_dir = 0
	
	if Input.is_action_pressed("move_left"):
		target_dir += -1
		$AnimatedSprite.play("walk left")
		
	if Input.is_action_pressed("move_right"):
		target_dir +=  1
		$AnimatedSprite.play("walk right")
		
	
	if Input.is_action_pressed("jump"):
		if !jumping:
			jumping = true
			jump_frames = JUMP_FRAMES
			velocity.y = -JUMP_SPEED
		
	if jumping:
		jump_frames -= 1
		if jump_frames < 0:
			velocity.y = 0 
			jumping = false
		if jump_frames<JUMP_FRAMES/2 && velocity.y<0:
			velocity.y = JUMP_SPEED
			
		
	if target_dir == 0: 
		$AnimatedSprite.stop()	
			
	last_dir = target_dir
	
	
		
	velocity.x = target_dir * WALK_SPEED
	
	move_and_slide(velocity)

