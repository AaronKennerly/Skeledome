extends CharacterBody2D
class_name Player

# Exported variables
@export var jump_state: PlayerState
@export var dash_state : PlayerState
@export var respawn_state : PlayerState
@export var block_state : PlayerState
@export var cancel_state : PlayerState
@export var right : PlayerAction
@export var left : PlayerAction
@export var jump : PlayerAction
@export var dash : PlayerAction
@export var slide : PlayerAction
@export var stomp : PlayerAction
@export var block : PlayerAction
@export var cancel : PlayerAction
@export var look_up : PlayerAction
@export var look_down : PlayerAction
@export var look_left : PlayerAction
@export var look_right : PlayerAction

@export var SPEED : float = 300.0
@export var ACCELERATION : float = 10.0
@export var DECELERATION : float = 20.0
@export var JUMP_BUFFER_TIME : float = 0.1
@export var JUMP_VELOCITY : float = -600.0
@export var JUMP_HEIGHT : int = 10
@export var DASH_SPEED : int = 800
@export var DASH_DURATION : float = .1
@export var SPAWNPOINT : Node2D
@export var BLOCKTIME : float = 5

@onready var state_machine : PlayerStateMachine = $PlayerStateMachine
@onready var collision_timer : Timer = $CollisionTimer

# Constants
const COYOTE_TIME : float = 0.2

# Member variables
var coyote_timer : float = 0.0
var jump_buffer_timer : float = -10.0
var block_timer : float = BLOCKTIME
var jump_bool : bool = false
var jump_count : int = 0
var can_dash : bool = true
var can_block : bool = true
var can_cancel : bool = true
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
var is_colliding : bool = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	pass




func _physics_process(delta) -> void:
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
	if state_machine.get_can_move() && state_machine.get_state() != block_state:
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
		
		if Input.is_action_pressed(dash.action) and can_dash:
			state_machine.switch_states(dash_state)
		
		if Input.is_action_pressed(block.action) and can_block:
			state_machine.switch_states(block_state)
		
		if Input.is_action_pressed(cancel.action) and can_cancel:
			state_machine.switch_states(cancel_state)

	# if the player goes out of bounds kill them
	if (position.y >= 750 or position.x <= -200 or position.x >= 1350) and player_joined:
		state_machine.switch_states(respawn_state)

	if state_machine.get_state() != block_state and can_block:
		if block_timer < BLOCKTIME:
			block_timer += delta
	
	set_velocity(velocity)
	move_and_slide()
	update_force(velocity)

func update_force(_velocity) -> void:
	force = _velocity * mass

# handle colision
func _on_touch_body_entered(body) -> void:
	if body.is_in_group("Player") && collision_timer.is_stopped():
		state_machine.get_state().collide(body)



