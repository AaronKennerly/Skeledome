extends Timer

class_name BlockCooldown

@export var player : CharacterBody2D

func on_timeout() -> void:
	player.can_block = true
	player.block_timer = player.BLOCKTIME
