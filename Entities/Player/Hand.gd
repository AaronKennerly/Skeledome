extends Sprite2D

class_name Hand


@export var player : Player

var direction : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Input.get_vector(player.look_right.action, player.look_left.action, player.look_up.action, player.look_down.action)
	rotation = atan2(direction.x, direction.y)

#func item_pickup():
#	self.texture = ssg_sprite
#	self.scale = Vector2(0.02,0.02)
#	player.current_item = ssg_item
#	#current_item = "ssg"
	
