extends Timer

@export var player : CharacterBody2D

func on_timeout():
	player.can_block = true
	player.block_timer = player.BLOCKTIME
