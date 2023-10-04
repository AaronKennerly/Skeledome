extends Timer

@export var player : Player

func _ready():
	player.can_block = false

func on_timeout():
	player.can_block = true
