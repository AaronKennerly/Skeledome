extends Timer

class_name CancelCooldown

@export var player : CharacterBody2D

func on_timeout():
	player.can_cancel = true
