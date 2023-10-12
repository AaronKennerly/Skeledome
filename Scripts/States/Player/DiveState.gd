extends PlayerState

class_name DiveState

var velocity


func on_enter():
	player.velocity.y = 0
	player.velocity.x = player.DIVESPEED * player.acceleration_direction
	$DiveTimer.start()
	player.can_dive = false

func state_process(_delta):
	player.velocity.x = player.DIVESPEED * player.acceleration_direction
	
# handle gravity 
	if player.velocity.y < 0:
		player.velocity.y += player.gravity * _delta 
	else:
		player.velocity.y += player.gravity * 2 * _delta
	
	if player.is_on_floor():
		player.can_jump = true
		end_dive()

func end_dive():
	next_state = air_state
