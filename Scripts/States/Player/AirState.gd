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
	if Input.is_action_just_pressed(player.jump.action) and !player.wall_coyote_timer.is_stopped():
		player.is_wall_jumping = true
		player.last_wall = player.which_wall
		# I don't know why acceleration_direction needs to be negative here. Please don't ask
		player.velocity.x = player.JUMP_VELOCITY * 3 * -player.acceleration_direction
		player.velocity.y = player.JUMP_VELOCITY * 0.8
		$"../WallState/WallJumpTimer".start()
	# handle jump
	elif Input.is_action_just_pressed(player.jump.action) and (player.coyote_timer > 0 or player.jump_count < 2) and !player.is_wall_jumping:
		height = player.position.y + player.JUMP_HEIGHT
		if player.coyote_timer < 0:
			player.jump_count += 1
		jump()
	elif Input.is_action_just_pressed(player.jump.action) and (player.coyote_timer > 0 or player.jump_count < 2) and player.is_wall_jumping:
		height = player.position.y + player.JUMP_HEIGHT
		if player.coyote_timer < 0:
			player.jump_count += 1
		player.jump_count += 1
		player.jump_bool = true
		player.velocity.y = lerp(player.velocity.y, player.JUMP_VELOCITY, 0.8)
		player.velocity.x = lerp(player.velocity.x, player.SPEED * player.acceleration_direction, 0.1)
	
	# handle stomp
	if Input.is_action_just_pressed(player.stomp.action):
		next_state = stomp_state
	
	# handle slide
	if Input.is_action_pressed(player.slide.action):
		next_state = dive_state
