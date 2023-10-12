extends PlayerState

class_name StompState

func on_enter() -> void:
	player.velocity.x = 0
	player.velocity.y = 800

func state_process(_delta) -> void:
	if player.is_on_floor():
		next_state = run_state
