extends Node2D

@export var player : CharacterBody2D

@onready var child = get_children()[0]

var max_distance = 1
var direction : Vector2
var look_axis : Vector2
var distance

func _process(_delta) -> void:
	
	look_axis = Input.get_vector(player.look_right.action, player.look_left.action, player.look_up.action, player.look_down.action)
	if look_axis.x != 0 && look_axis.y != 0:
		direction = Vector2.ZERO.direction_to(look_axis)
	child.position = direction
