extends StateMachine

class_name PlayerStateMachine

# can player move in this state?
func get_can_move() -> bool:
	return current_state.can_move
