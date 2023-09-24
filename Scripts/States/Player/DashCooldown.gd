extends Timer

class_name DashCooldown

var player : CharacterBody2D


func _on_timer_timeout():
	player.can_dash = true
