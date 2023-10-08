extends Timer

class_name DashCooldown

@export var player : CharacterBody2D


func on_timeout() -> void:
	player.can_dash = true
