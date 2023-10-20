extends PlayerState

class_name WallState

func on_enter() -> void:
	# I do not understand why this is necessary, but it is
	if player.velocity.y < 0:
		player.velocity.y *= 0.95
	if !player.wall_jump_buffer.is_stopped() and player.coyote_timer <= 0 and player.momentum_direction.x != player.acceleration_direction and player.which_wall != player.last_wall:
		player.acceleration_direction *= -1
		wall_jump()

func state_process(_delta) -> void:
	if player.which_wall == 1 and Input.is_action_pressed(player.right.action) and player.is_on_wall_only():
		if player.velocity.y > 0:
			player.velocity.y = min(player.WALLSLIDESPEED, player.velocity.y + (player.gravity * 0.5 * _delta))
		else:
			player.velocity.y += (player.gravity * 0.5 * _delta)
	elif player.which_wall == 2 and Input.is_action_pressed(player.left.action) and player.is_on_wall_only():
		if player.velocity.y > 0:
			player.velocity.y = min(player.WALLSLIDESPEED, player.velocity.y + (player.gravity * 0.5 * _delta))
		else:
			player.velocity.y += (player.gravity * 0.5 * _delta)
	else:
		next_state = air_state
		if player.momentum_direction.x == player.acceleration_direction:
			player.wall_coyote_timer.start()
		
	
	if Input.is_action_just_pressed(player.jump.action) and player.which_wall != player.last_wall:
		wall_jump()
		
	if player.is_wall_jumping && player.acceleration_direction != player.momentum_direction.x:
		player.velocity.x += player.ACCELERATION * player.momentum_direction.x


func end_jump() -> void:
	if !player.is_on_wall_only():
		next_state = air_state

func wall_jump() -> void:
	player.is_wall_jumping = true
	player.last_wall = player.which_wall
	player.velocity.x = player.JUMP_VELOCITY * 3 * player.acceleration_direction
	player.velocity.y = player.JUMP_VELOCITY * 0.8
	$WallJumpTimer.start()

