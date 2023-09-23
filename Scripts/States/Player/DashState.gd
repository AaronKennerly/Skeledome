extends PlayerState

class_name DashState

@export var air_state : PlayerState
@export var ground_state : PlayerState

var timer

func on_enter():
	timer = $DashTimer
	player.velocity.x += player.DASH_SPEED
	start_dash(player.DASH_DURATION)
#
#func _physics_process(delta):
#	if timer.is_stoped():
#		if player.is_on_floor():
#			next_state = ground_state
#		else:
#			next_state = air_state


func start_dash(duration):
	timer.wait_time = duration
	timer.start()



