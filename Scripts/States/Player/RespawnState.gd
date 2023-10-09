extends PlayerState

class_name RespawnState

@export var air_state : PlayerState

func on_enter() -> void:
	# stop physics and hide the player
	player.set_collision_layer_value(1, false)
	player.set_collision_mask_value(1, false)
	player.set_physics_process(false)
	player.hide()
	# decrease the death count and start the timer
	player.deaths -= 1
	if player.deaths == 0:
		player.dead = true
		player.velocity.y = 0
		player.velocity.x = 0
	else:
		$RespawnTimer.start()
		GameManager.respawn_player(player)


func state_process(_delta) -> void:
	if !player.is_on_floor():
		next_state = air_state


func _on_respawn_timer_timeout() -> void:
	# set the velocities to 0
	player.velocity.y = 0
	player.velocity.x = 0
	# move and resume the player
	player.show()
	player.set_physics_process(true)
	player.set_collision_layer_value(1, true)
	player.set_collision_mask_value(1, true)
