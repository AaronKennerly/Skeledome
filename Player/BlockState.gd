extends PlayerState

class_name BlockState

@export var air_state : PlayerState

@export var block_cooldown : Timer


func on_enter():
	player.block_timer = player.block_time

func state_process(delta):
	if player.is_on_floor():
		if player.velocity.x > 0:
			player.velocity.x = max(player.velocity.x - player.DECELERATION * 2, 0)
		else:
			player.velocity.x = min(player.velocity.x + player.DECELERATION * 2, 0)
	else:
		if player.velocity.x < 0:
			player.velocity.x += player.gravity * 2 * delta
		else:
			player.velocity.x -= player.gravity * 2 * delta
	
	player.block_timer -= delta
	
	if player.block_timer <= 0:
		next_state = air_state
		block_cooldown.start()

func state_input(event : InputEvent):
	if !Input.is_action_just_pressed(player.jump.action):
		next_state = air_state


func collide(body):
	player.is_colliding = true
	player.velcocity += body.velocity * 0.25
	body.velocity *= -2
	player.collision_timer.start()
	player.block_timer -= 1
