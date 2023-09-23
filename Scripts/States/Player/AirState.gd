extends PlayerState

class_name AirState

@export var run_state : PlayerState

func state_process(delta):
	if(player.is_on_floor()):
		next_state = run_state
	
		player.coyote_timer -= delta # subtract from coyote time

	# handle gravity
	if player.velocity.y < 0:
		player.velocity.y += player.gravity * delta
	else:
		player.velocity.y += player.gravity * 2 * delta
	
	# When jump button is released (Janky solution. Reassess)
	if not Input.is_action_pressed(player.controls.jump) and player.jump_bool:
		player.velocity.y = player.velocity.y + 400.0
		player.coyote_timer = 0
		player.jump_bool = false
	


func state_input(event : InputEvent):
	# Handle Jump.
	if Input.is_action_just_pressed(player.controls.jump) and (player.coyote_timer > 0 or player.jump_count < 2):
		if player.coyote_timer < 0:
			player.jump_count += 1
		jump()
