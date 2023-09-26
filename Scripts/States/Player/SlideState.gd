extends PlayerState

class_name SlideState

@export var run_state : PlayerState
@export var air_state : PlayerState
@export var slide_timer : Timer
@export var deceleration : int

var velocity : Vector2

func on_enter():
	start_slide()


func state_process(_delta):
	if player.direction.x > 0:
		player.velocity.x = max(player.velocity.x - deceleration, 0)
	else:
		player.velocity.x = min(player.velocity.x + deceleration, 0)
	if !player.is_on_floor():
		next_state = air_state
	if player.velocity.x == 0:
		on_exit()

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

func state_input(_event : InputEvent):
	# Handle Jump.
	if Input.is_action_just_pressed(player.jump.action):
		player.jump_count += 1
		player.jump_bool = true
		player.velocity.y = player.JUMP_VELOCITY
		next_state = air_state



