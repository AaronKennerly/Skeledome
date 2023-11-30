extends Timer

class_name StompTimer

@export var state_machine : StateMachine

func _on_time_out():
	state_machine.can_dash = true
	state_machine.can_jump = true
	state_machine.can_move = true
	state_machine.can_block = true
	state_machine.can_dive = true
