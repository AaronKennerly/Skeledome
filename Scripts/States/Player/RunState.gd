extends PlayerState

class_name RunState

@export var JUMP_VELOCITY = -600.0
@export var jump_state : PlayerState

var jump_count = 0

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump1")):
		jump()


func jump():
	jump_count += 1
	player.velocity.y = JUMP_VELOCITY
	next_state = jump_state

