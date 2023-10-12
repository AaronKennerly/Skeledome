extends Timer

class_name DiveTimer

@export var player : CharacterBody2D

func _on_timeout():
	player.can_jump = true
