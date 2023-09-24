extends PlayerState

class_name DashState

@export var air_state : PlayerState
@export var ground_state : PlayerState

var dash_timer
var dash_cooldown

func on_enter():
	dash_timer = $DashTimer
	dash_cooldown = $DashCooldown
	if (player.can_dash):
		if (player.velocity.x > 0):
			player.velocity.x += player.DASH_SPEED
		else: 
			player.velocity.x -= player.DASH_SPEED
	
	start_dash(player.DASH_DURATION)

func _physics_process(delta):
	pass



func start_dash(duration):
	dash_timer.wait_time = duration
	dash_timer.start()

func _on_timer_timeout():
	if player.is_on_floor():
		next_state = ground_state
	else:
		next_state = air_state
		
func on_exit():
	player.can_dash = false
	dash_cooldown.wait_time = player.dash_cooldown
	dash_cooldown.start()



