extends PlayerState

class_name AirState

func on_enter() -> void:
	height = player.position.y + player.JUMP_HEIGHT

# TODO: Fix Dash issue
func state_process(_delta) -> void:
	# constantly check if player has landed, else subtract from coyote time
	if(player.is_on_floor()):
		next_state = run_state
	else:
		player.coyote_timer -= _delta

	# handle gravity 
	if player.is_wall_jumping:
		if player.acceleration_direction != player.momentum_direction.x:
			player.velocity.x += player.ACCELERATION * player.momentum_direction.x
		player.velocity.x = lerp(player.velocity.x, player.acceleration_direction * player.ACCELERATION * _delta, 0.1)
	if player.velocity.y < 0:
		player.velocity.y += player.gravity * _delta
	else:
		player.velocity.y += player.gravity * 2 * _delta
			
	#TODO: Look at janky solution
	# When jump button is released (Janky solution. Reassess)
	if (not Input.is_action_pressed(player.jump.action) or player.position.y <= height) and player.jump_bool:
		player.velocity.y = player.velocity.y + 200.0
		player.coyote_timer = 0
		player.jump_bool = false


func state_input(_event : InputEvent) -> void:
	# handle jump
	if Input.is_action_just_pressed(player.jump.action) and (player.coyote_timer > 0 or player.jump_count < 2):
		height = player.position.y + player.JUMP_HEIGHT
		if player.coyote_timer < 0:
			player.jump_count += 1
		jump()
	
	# handle stomp
	if Input.is_action_just_pressed(player.stomp.action):
		next_state = stomp_state
	
	# handle slide
	if Input.is_action_pressed(player.slide.action):
		next_state = dive_state
