extends PlayerState

class_name SlideState

@export var deceleration : int


func on_enter() -> void:
	start_slide()


func state_process(_delta) -> void:
	if player.momentum_direction.x > 0:
		player.velocity.x = max(player.velocity.x - deceleration, 0)
	else:
		player.velocity.x = min(player.velocity.x + deceleration, 0)
	if !player.is_on_floor():
		next_state = air_state
	if player.velocity.x == 0:
		on_exit()

func on_exit() -> void:
	if(player.is_on_floor()):
		next_state = run_state
	else:
		next_state = air_state

func start_slide() -> void:
	$SlideTimer.start()

func collide(body) -> void:
	body.velocity.y -= abs(player.velocity.x)
	body.velocity.y -= player.velocity.y

func state_input(_event : InputEvent) -> void:
	# Handle Jump.
	if Input.is_action_just_pressed(player.jump.action):
		player.jump_count += 1
		player.jump_bool = true
		player.velocity.y = player.JUMP_VELOCITY
		next_state = air_state



