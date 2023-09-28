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
@export var stomp : PlayerAction

@export var SPEED : float = 300.0
@export var ACCELERATION : float = 10.0
@export var DECELERATION : float = 20.0
@export var JUMP_BUFFER_TIME : float = 0.1
@export var JUMP_VELOCITY : float = -600.0
@export var JUMP_HEIGHT : int = 10
@export var DASH_SPEED : int = 800
@export var DASH_DURATION : float = .1
@export var SPAWNPOINT : Node2D

@onready var state_machine : PlayerStateMachine = $PlayerStateMachine
@onready var collision_timer : Timer = $CollisionTimer

# Constants
const COYOTE_TIME : float = 0.2

# Member variables
var coyote_timer : float = 0.0
var jump_buffer_timer : float = -10.0
var jump_bool : bool = false
var jump_count : int = 0
var can_dash : bool = true
var dash_cooldown : float = 3.0
var respawn_timer : Timer
var touch : Area2D
var force : Vector2
var mass : float = 60.0
var deaths : int = 3
var dead : bool = false
var is_dashing : bool = false
var direction : Vector2
var player_joined : bool = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass




func _physics_process(delta):
	velocity = get_velocity()
	if velocity.x != 0:
		direction.x = velocity.x / abs(velocity.x)
	if velocity.y != 0:
		direction.y = velocity.y / abs(velocity.y)
	
	
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
			if is_on_floor():
				if velocity.x > 0:
					velocity.x = max(velocity.x - DECELERATION, 0)
				else:
					velocity.x = min(velocity.x + DECELERATION, 0)
			else:
				if velocity.x < 0:
					velocity.x += gravity * delta
				else:
					velocity.x -= gravity * delta
		
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
	if body.is_in_group("Player") && collision_timer.is_stopped():
		state_machine.get_state().collide(body)



