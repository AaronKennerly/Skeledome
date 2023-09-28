extends PlayerState

class_name DashState

@export var air_state : PlayerState
@export var ground_state : PlayerState
@export var dash_timer: Timer
@export var dash_cooldown : Timer

var velocity : Vector2
var target : Vector2


# add dash velocity in direction of current velocity
func on_enter():
	if (player.can_dash):
		player.is_dashing = true
		target = player.get_global_mouse_position()
		velocity = player.position.direction_to(target) * player.DASH_SPEED
		start_dash(player.DASH_DURATION)
	else:
		push_warning("Player should not have been sent to dash state")


# wait for dash_timer to end
func state_process(_delta):
	velocity.y += player.gravity * 2 * _delta
	player.velocity = velocity


# start timer
func start_dash(duration):
	dash_timer.wait_time = duration
	dash_timer.start()
	player.is_dashing = true


# start dash cooldown and set next state
func on_exit():
	player.can_dash = false
	dash_cooldown.wait_time = player.dash_cooldown
	dash_cooldown.start()
	player.velocity = velocity
	player.is_dashing = false
	if player.is_on_floor():
		next_state = ground_state
	else:
		next_state = air_state



