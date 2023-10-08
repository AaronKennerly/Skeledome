extends Timer

class_name BlockCooldownq

@export var player : CharacterBody2D

func on_timeout() -> void:
	player.can_block = true
	player.block_timer = player.BLOCKTIME
