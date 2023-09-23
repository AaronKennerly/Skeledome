extends PlayerState

class_name RunState

@export var air_state : PlayerState

func state_process(delta):
	# reset timer and jumps
	player.coyote_timer = player.COYOTE_TIME
	player.jump_count = 0
	player.jump_bool = false

	if player.jump_buffer_timer >= 0 and player.is_on_floor():
		player.jump_count = 0
		jump()
	
	if not player.is_on_floor():
		next_state = air_state



func state_input(event : InputEvent):
	# Handle Jump.
	if Input.is_action_just_pressed(player.controls.jump) and (player.coyote_timer > 0 or player.jump_count < 2):
		if player.coyote_timer < 0:
			player.jump_count += 1
		jump()


func jump():
	player.jump_count += 1
	player.jump_bool = true
	player.velocity.y = player.JUMP_VELOCITY
	next_state = air_state



