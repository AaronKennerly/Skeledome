extends PlayerState

class_name AirState

@export var run_state : PlayerState
@export var stomp_state : PlayerState

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
	# handle wall jump (placeholder currently)
	#if Input.is_action_pressed(player.jump.action) and (player.is_on_wall_only()):
		#player.jump_bool = true
		#player.velocity.y = player.JUMP_VELOCITY
	
	# handle jump
	if Input.is_action_just_pressed(player.jump.action) and (player.coyote_timer > 0 or player.jump_count < 2):
		height = player.position.y + player.JUMP_HEIGHT
		if player.coyote_timer < 0:
			player.jump_count += 1
		jump()
	
	# handle stomp
	if Input.is_action_just_pressed(player.stomp.action):
		next_state = stomp_state
