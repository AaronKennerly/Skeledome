extends PlayerState

class_name StunnedState

@export var stun_timer : Timer
@export var air_state : PlayerState
@export var cancel_state : PlayerState

func on_enter() -> void:
	stun_timer.start()


func state_input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed(player.cancel.action) and player.can_cancel:
		next_state = cancel_state

func end_stun() -> void:
	next_state = air_state
