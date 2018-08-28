extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var old_shape
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	old_shape = $CollisionShape2D.get_shape()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var y = get_node("../Player").position.y
	if  y + 5 > position.y: 
		self.add_collision_exception_with(get_node("../Player"))
		#$CollisionShape2D.disabled = true
	else:
		#$CollisionShape2D.disabled = false
		self.remove_collision_exception_with(get_node("../Player"))
