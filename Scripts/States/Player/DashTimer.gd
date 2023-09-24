extends Timer

@export var ground_state : PlayerState
@export var air_state : PlayerState

var player : CharacterBody2D

func _on_timer_timeout():
	if player.is_on_floor():
		player.next_state = ground_state
	else:
		player.next_state = air_state
