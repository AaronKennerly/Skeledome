extends PlayerState

class_name WallState

func state_process(_delta) -> void:
	if player.which_wall == 1 && Input.is_action_pressed(player.right.action) && player.is_on_wall_only():
		player.velocity.y += player.WALLSLIDESPEED * _delta
	elif player.which_wall == 2 && Input.is_action_pressed(player.left.action) && player.is_on_wall_only():
		player.velocity.y += player.WALLSLIDESPEED * _delta
	else:
		next_state = air_state
	
	if Input.is_action_just_pressed(player.jump.action) && player.which_wall != player.last_wall:
#		player.can_move = false
		player.is_wall_jumping = true
		player.last_wall = player.which_wall
		jump()
		player.velocity.x = player.JUMP_VELOCITY * 2 * player.acceleration_direction
		$WallJumpTimer.start
		
	if player.is_wall_jumping && player.acceleration_direction != player.momentum_direction.x:
		player.velocity.x += player.ACCELERATION * player.momentum_direction.x
	
	player.velocity.x = lerp(player.velocity.x, player.acceleration_direction * player.ACCELERATION * _delta, 0.1)
	
#	player.velocity.x = lerp(player.velocity.x,player.ACCELERATION * player.acceleration_direction * _delta, 0.01)
#func state_input(_event: InputEvent) -> void:
#


func end_jump():
	if !player.is_on_wall_only():
		next_state = air_state
