extends Timer

class_name StompTimer

@export var player : CharacterBody2D

func _on_time_out():
	player.can_dash = true
	player.can_jump = true
	player.can_move = true
	player.can_block = true
	player.can_dive = true
