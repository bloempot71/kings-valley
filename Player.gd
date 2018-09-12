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
var dropped_sword_anti_jump = 20
var on_stairs = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	pass

func _physics_process(delta):
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
		
	#if up_stairs:
	#	#target_dir = 0
	#	velocity.y = -1 * WALK_SPEED
	#	#print(velocity)
		
		
	#on_stairs = self.position.y <= get_node("../Stairs2/Smart Stairs").position.y+5 and self.position.y >= get_node("../Stairs2/Smart Stairs6").position.y-5
	#print(self.position.y, " ", get_node("../Stairs2/Smart Stairs").position.y, " ",  get_node("../Stairs2/Smart Stairs6").position.y)
	
	if Input.is_action_pressed("move_down"):
		var ph = $AnimatedSprite.frames.get_frame(right_anim, 0).get_size();
		var nf = get_node("../Smart Stairs Floor")
		
		# is the player on top of this and pressing down? 
		#print(ph, nf.position, self.position)
		if self.position.x > nf.position.x-10 and self.position.x < nf.position.x-5 and abs(self.position.y+ph.y/2-nf.position.y)<5:
			nf.add_collision_exception_with(get_node("../Player"))
		#else:
			#print("close this")
	else: # no worky this 
		var nf = get_node("../Smart Stairs Floor")
		#nf.remove_collision_exception_with(get_node("../Player"))
			
	# feature, you cannot correct direction while jumping 
	# as that doesn't happen in the original
	if jumping:
		target_dir = last_dir 
			
	if dropped_sword_anti_jump>0:
		dropped_sword_anti_jump -= 1
			
	# if we are jumping, this is a special movement
	if Input.is_action_pressed("jump"):
		if dropped_sword_anti_jump <= 0 && !has_sword && !jumping:
			jumping = true
			jump_frames = JUMP_FRAMES
			velocity.y = -JUMP_SPEED
		if has_sword: 
			dropped_sword_anti_jump = 20
			#var sword = load("res://Sword.gd").new()
			get_node("../Sword").get_node("AnimatedSprite").play("flying sword")
			
			get_node("../Sword").position.x = position.x + 6 + 10 * last_dir
			get_node("../Sword").position.y = position.y
			get_node("../Sword").velocity.x = 200 * last_dir
			has_sword = false
			left_anim = "walk left"
			right_anim = "walk right"
			#add_child(sword)
		
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
			
	if target_dir != 0:
		last_dir = target_dir
		
	velocity.x = target_dir * WALK_SPEED
	#print(velocity)
	move_and_slide(velocity)
	
	# did we hit something that is of value? 
	if get_slide_count() > 0:
		#var stairs_count = 0
		#for i in range (0,get_slide_count()):
		#	var c = get_slide_collision(i).collider
		#	if c == get_node("../Stairs"):
		#		pass
					
					
		for i in range (0,get_slide_count()):
			var c = get_slide_collision(i).collider
			print(c)
			#if on_stairs && c == get_node("../Walls"):
			#	position += velocity
			
			
			
				
			#if c == get_node("../Stairs2/Smart Stairs6"):
			if "Smart Stairs" in str(c.get_path()):
				#print(c.get_path())
				#get_node("../Player").position.x += 7
				if Input.is_action_pressed("move_up"):
					
					#for i in range(1,7):
					#	var j = str(i) 
					#	if i==1:
					#		j = ""
					#	var c1 = get_node("../Stairs2/Smart Stairs"+j)
					#	#c1.add_collision_exception_with(get_node("../Player"))
					var c1 = get_node("../Smart Wall")
					c1.add_collision_exception_with(get_node("../Player"))
					c1 = get_node("../Smart Wall2")
					c1.add_collision_exception_with(get_node("../Player"))
					c1 = get_node("../Smart Stairs Floor")
					c1.add_collision_exception_with(get_node("../Player"))
					
					if c.get_name() == "Smart Stairs":
						get_node("../Player").position.x -= 0
						get_node("../Player").position.y -= 5
						c1.remove_collision_exception_with(get_node("../Player"))
					else:
						get_node("../Player").position.y -= 2
					
					
					
					#var space_state = get_world_2d().direct_space_state
					#var ph = $AnimatedSprite.frames.get_frame(left_anim, 0).get_size();
					#var pp = get_node("../Player").position
					#var br = c1.position 
					#var brs = c1.get_node("Sprite").texture.get_size()
					
					#print("player size ", ph, pp, br, brs)
					
					#pp.x += ph.x/2
					#br.x += br.x/2
					
					#get_node("../../Kings Valley")
					
					
					#var result = space_state.intersect_ray(pp, br)
					#if result:
					#	print("Hit at point: ", result.position)
					#c1.add_collision_exception_with(get_node("../Player"))
					#up_stairs = true
					#move_and_slide(velocity)
					#print(c)
			if c == get_node("../Sword"):
				c.position.x = -100
				c.position.y = -100
				left_anim = "sword left"
				right_anim = "sword right"
				has_sword = true

