extends PlayerState

class_name CancelState

func on_enter() -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	$CancelTimer.start()


func state_process(delta) -> void:
	player.velocity.x = 0
	player.velocity.y = 0


func end_cancel() -> void:
	player.can_cancel = false
	$CancelCooldown.start()
	next_state = air_state
