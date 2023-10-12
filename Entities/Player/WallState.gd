extends PlayerState

class_name WallState

@export var wall_fall_speed : float

func state_process(_delta) -> void:
	player.velocity.y = wall_fall_speed * (0.5 * _delta)

func state_input(_event: InputEvent) -> void:
	if _event == player.jump.action:
		pass
	
	
