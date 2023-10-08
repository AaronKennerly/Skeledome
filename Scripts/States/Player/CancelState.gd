extends PlayerState

class_name CancelState

@export var air_state : PlayerState

@export var cancel_timer : Timer
@export var cancel_cooldown : Timer

func on_enter():
	player.velocity.x = 0
	player.velocity.y = 0
	cancel_timer.start()


func state_process(delta):
	player.velocity.x = 0
	player.velocity.y = 0


func end_cancel():
	player.can_cancel = false
	cancel_cooldown.start()
	next_state = air_state
