extends Timer

class_name DashCooldown

@export var player : CharacterBody2D


func _on_timeout():
	player.can_dash = true
