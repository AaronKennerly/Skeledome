extends Node2D

@onready var child = get_children()[0]

var max_distance = 1
var mouse_postition
var direction
var distance

func _process(_delta):
	mouse_postition = get_local_mouse_position()
	direction = Vector2.ZERO.direction_to(mouse_postition)
	child.position = direction
