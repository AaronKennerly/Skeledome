extends Timer

class_name WallJumpTimer

@export var player : Player

func _on_timeout():
	player.can_move = true
