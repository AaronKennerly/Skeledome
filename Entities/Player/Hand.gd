extends Sprite2D

@onready var ssg_sprite = load("res://Assets/Art/Items/ssg.png")


@export var player : Player
@export var ssg_item : Item


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func item_pickup():
	self.texture = ssg_sprite
	self.scale = Vector2(0.02,0.02)
	player.current_item = ssg_item
	#current_item = "ssg"
	
