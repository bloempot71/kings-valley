extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const FLOOR_NORMAL = Vector2(0, -1)
const WALK_SPEED = 100 
const FALL_SPEED = 100
const JUMP_SPEED = 150
const JUMP_FRAMES = 50

var velocity = Vector2()
var jump_frames = 60
var jumping = false
var last_dir = 0
var left_anim = "walk left"
var right_anim = "walk right"
var has_sword = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	# if we are not jumping, test for a floor
	if !jumping:
		velocity.y = FALL_SPEED # gravity		
		velocity  = move_and_slide(velocity)#, FLOOR_NORMAL)
		
			

	var target_dir = 0
	
	if Input.is_action_pressed("move_left"):
		target_dir += -1
		$AnimatedSprite.play(left_anim)
		
	if Input.is_action_pressed("move_right"):
		target_dir +=  1
		$AnimatedSprite.play(right_anim)
		
	# only for testing! 
	#if Input.is_action_pressed("move_up"):
	#	velocity.y = -100
	#if Input.is_action_pressed("move_down"):
	#	velocity.y = 100			
		
	# if we are jumping, this is a special movement
	if Input.is_action_pressed("jump"):
		if !has_sword && !jumping:
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
			
	# if we are standing still, don't keep animating
	if target_dir == 0: 
		$AnimatedSprite.stop()	
			
	last_dir = target_dir
		
	velocity.x = target_dir * WALK_SPEED
	
	move_and_slide(velocity)
	
	# did we hit something that is of value? 
	if get_slide_count() > 0:
		for i in range (0,get_slide_count()):
			var c = get_slide_collision(i).collider
			if c == get_node("../Sword"):
				c.queue_free()
				left_anim = "sword left"
				right_anim = "sword right"
				has_sword = true

