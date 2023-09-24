extends PlayerState

class_name SlideState

@export var run_state : PlayerState
@export var air_state : PlayerState
@export var slide_timer : Timer

var velocity : Vector2

func on_enter():
	velocity = player.get_velocity()
	start_slide()


func state_process(delta):
	player.velocity = velocity
	if !player.is_on_floor():
		next_state = air_state

func on_exit():
	if(player.is_on_floor()):
		next_state = run_state
	else:
		next_state = air_state

func start_slide():
	slide_timer.start()

func collide(body):
	body.velocity.y -= abs(player.velocity.x)
	body.velocity.y -= player.velocity.y



