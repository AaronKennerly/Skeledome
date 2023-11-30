extends State

class_name ItemState

@export var can_use : bool = true
@export var can_throw : bool = true

@onready var hand = get_node("../../Body/Pivot/Hand")

var uses : int

func action():
	pass

func throw():
	pass
