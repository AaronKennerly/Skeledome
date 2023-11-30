extends State

class_name ItemState

@export var can_use : bool = true
@export var can_throw : bool = true

@onready var hand = get_node("../../Body/Pivot/Hand")
@onready var ssg_sprite = load("res://Assets/Art/Items/ssg.png")

var aim : Vector2
var uses : int

func on_enter():
	pass

func action():
	pass

func throw():
	pass

func on_exit():
	pass
