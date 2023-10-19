extends PlayerState

class_name BlockState

func state_process(delta) -> void:
	if player.is_on_floor():
		if player.velocity.x > 0:
			player.velocity.x = max(player.velocity.x - player.DECELERATION * 2, 0)
		else:
			player.velocity.x = min(player.velocity.x + player.DECELERATION * 2, 0)
	else:
		#player.velocity.y *= 0.5
		player.velocity.x += player.gravity * -player.momentum_direction.x * 2 * delta
		player.velocity.y += player.gravity * 2 * delta
	
	player.block_timer -= delta
	
	if player.block_timer <= 0:
		next_state = stun_state
		$BlockCooldown.start()

func state_input(_event : InputEvent) -> void:
	if !player.block.is_holding():
		next_state = air_state


func collide(body) -> void:
	player.is_colliding = true
	player.velcocity += body.velocity * 0.25
	body.velocity *= -2
	player.collision_timer.start()
	player.block_timer -= 1
