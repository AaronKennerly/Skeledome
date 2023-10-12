extends PlayerState

class_name WallState

func state_process(_delta) -> void:
	if player.which_wall == 1 && Input.is_action_pressed(player.right.action) && player.is_on_wall_only():
		player.velocity.y += player.WALLSLIDESPEED * _delta
	elif player.which_wall == 2 && Input.is_action_pressed(player.left.action) && player.is_on_wall_only():
		player.velocity.y += player.WALLSLIDESPEED * _delta
	else:
		next_state = air_state

func state_input(_event: InputEvent) -> void:
	if _event.is_action(player.jump.action) && player.which_wall != player.last_wall:
		player.can_move = false
		$WallJumpTimer.start()
		player.last_wall = player.which_wall
		player.velocity.x = player.JUMP_VELOCITY * 2 * player.acceleration_direction
		player.velocity.y = player.JUMP_VELOCITY
		next_state = air_state
