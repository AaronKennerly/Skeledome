extends Timer

class_name WallJumpTimer

@export var player : Player

func _on_timeout():
	player.is_wall_jumping = false
	player.can_move = true
