extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const FALL_SPEED = 100
var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if position.x>0:
		if velocity.x == 0:
			velocity.y = FALL_SPEED # gravity		
		velocity  = move_and_slide(velocity)#, FLOOR_NORMAL)
		if velocity.x == 0 && velocity.y == 0:
			$AnimatedSprite.stop()
		else:
			$AnimatedSprite.play("flying sword")
