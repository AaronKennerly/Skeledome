extends CharacterBody2D
class_name Player

# Exported variables
@export var jump_state: PlayerState
@export var dash_state : PlayerState
@export var respawn_state : PlayerState
@export var right : PlayerAction
@export var left : PlayerAction
@export var jump : PlayerAction
@export var dash : PlayerAction
@export var slide : PlayerAction

@onready var state_machine : PlayerStateMachine = $PlayerStateMachine

# Constants
const SPEED = 300.0
const ACCELERATION = 10.0
const DECELERATION = 20.0
const JUMP_BUFFER_TIME = 0.1
const COYOTE_TIME = 0.2
const JUMP_VELOCITY = -600.0
const DASH_SPEED = 800
const DASH_DURATION = .1

# Member variables
var coyote_timer = 0.0
var jump_buffer_timer = -10.0
var jump_bool = false
var jump_count = 0
var can_dash = true
var dash_cooldown = 3.0
var respawn_timer : Timer
var touch : Area2D
var force : Vector2
var mass = 60.0
var deaths = 3
var dead = false
var is_dashing = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	respawn_timer = $RespawnTimer




func _physics_process(delta):
	velocity = get_velocity()
	
	
	#TODO: Change to timer node
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	#TODO: Chnage to timer node
	if Input.is_action_just_pressed(jump.action):
		jump_buffer_timer = JUMP_BUFFER_TIME
	
	# calculating Base Movement
	if state_machine.get_can_move():
		if Input.is_action_pressed(left.action):
			if velocity.x > 0:
				velocity.x *= 0.75 #If changing direction, happens slightly faster, feeling better
			velocity.x = max(velocity.x - ACCELERATION, -SPEED)
		elif Input.is_action_pressed(right.action):
			if velocity.x < 0:
				velocity.x *= 0.75
			velocity.x = min(velocity.x + ACCELERATION, SPEED)
		else:
			if velocity.x > 0:
				velocity.x = max(velocity.x - DECELERATION, 0)
			else:
				velocity.x = min(velocity.x + DECELERATION, 0)
		
		if Input.is_action_pressed(dash.action):
			if can_dash:
				state_machine.switch_states(dash_state)

	# if the player goes out of bounds kill them
	if position.y >= 750 or position.x <= -200 or position.x >= 1350:
		state_machine.switch_states(respawn_state)

	
	set_velocity(velocity)
	move_and_slide()
	update_force(velocity)

func update_force(_velocity):
	force = _velocity * mass

# handle colision
func _on_touch_body_entered(body):
	if body.is_in_group("Player"):
		state_machine.get_state().collide(body)



