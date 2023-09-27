extends PlayerState

class_name StompState

@export var run_state : PlayerState

func on_enter():
	player.velocity.x = 0
	player.velocity.y = 800

func state_process(delta):
	if player.is_on_floor():
		next_state = run_state
