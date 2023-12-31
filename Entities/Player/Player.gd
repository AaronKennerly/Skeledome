extends CharacterBody2D
class_name Player

# Exported variables
@export var player_state_machine : StateMachine
@export var air_state: PlayerState
@export var dash_state : PlayerState
@export var respawn_state : PlayerState
@export var block_state : PlayerState
@export var cancel_state : PlayerState
@export var wall_state : PlayerState

@export var item_state_machine : StateMachine
@export var none : ItemState
@export var ssg : ItemState

@export var hand : Sprite2D

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
@export var item : PlayerAction

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
@export var DIVESPEED : float = 1200
@export var WALLSLIDESPEED : float = 600

@onready var collision_timer : Timer = $CollisionTimer
@onready var wall_coyote_timer : Timer = $WallCoyoteTimer
@onready var wall_jump_buffer : Timer = $WallJumpBuffer
@onready var kill_timer : Timer = $KillTimer

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
var can_dive : bool = true
var can_jump : bool = true
var can_move : bool = true

var dash_cooldown : float = 3.0
var respawn_timer : Timer
var touch : Area2D
var force : Vector2
var mass : float = 60.0
var deaths : int = 3
var hits : int = 0
var kills : int = 0
var wins : int = 0
var dead : bool = false
var is_dashing : bool = false
var momentum_direction : Vector2 # what direction player is being actively going
var acceleration_direction : int # what direction player is trying to go
var player_joined : bool = false
var is_colliding : bool = false
var which_wall : int = 0 # 1 for right 2 for left
var last_wall : int = 0
var is_wall_jumping : bool = false
var is_blocking : bool = false
var momentum_tracker : float = 0
var is_on_fire : bool = false
var is_in_big_mode : bool = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	pass




func _physics_process(delta) -> void:
	velocity = get_velocity()
	if velocity.x != 0:
		momentum_direction.x = velocity.x / abs(velocity.x)
	if velocity.y != 0:
		momentum_direction.y = velocity.y / abs(velocity.y)
		
	if Input.is_action_pressed(left.action):
		acceleration_direction = -1
	elif Input.is_action_pressed(right.action):
		acceleration_direction = 1
	else:
		acceleration_direction = 0
	
	if is_on_floor():
		which_wall = 0
		last_wall = 0
		is_wall_jumping = false
	
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	if Input.is_action_just_pressed(jump.action):
		jump_buffer_timer = JUMP_BUFFER_TIME
		wall_jump_buffer.start()

	# calculating Base Movement
	if player_state_machine.get_can_move() && can_move && player_state_machine.get_state() != block_state:
		
		if Input.is_action_pressed(left.action):
			if is_on_wall_only():
				player_state_machine.set_state(wall_state)
				which_wall = 2
			if velocity.x > 0:
				velocity.x *= 0.75 #If changing direction, happens slightly faster, feeling better
			velocity.x = max(velocity.x - ACCELERATION, -SPEED)
			
		elif Input.is_action_pressed(right.action):
			if is_on_wall_only():
				player_state_machine.set_state(wall_state)
				which_wall = 1
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
			player_state_machine.set_state(dash_state)
		
		if Input.is_action_pressed(block.action) and can_block:
			player_state_machine.set_state(block_state)
		
		if Input.is_action_pressed(cancel.action) and can_cancel:
			player_state_machine.set_state(cancel_state)
			
		if Input.is_action_just_pressed(stomp.action) and is_on_floor():
			position.y += 1
		
		if Input.is_action_just_pressed(item.action):
			item_state_machine.get_state().action()

	# if the player goes out of bounds kill them
	if (position.y >= 955 or position.x <= -575 or position.x >= 1735) and player_joined:
		player_state_machine.set_state(respawn_state)

	if player_state_machine.get_state() != block_state and can_block:
		if block_timer < BLOCKTIME:
			block_timer += delta
	
	if is_wall_jumping:
		velocity.x = lerp(velocity.x, acceleration_direction * ACCELERATION * delta, 0.01)
	
	if abs(velocity.x) == SPEED:
		momentum_tracker += delta 
		
	if (hits >= 3 && !dead): 
		hits = 0
		player_state_machine.set_state(respawn_state)
	
	
	set_velocity(velocity)
	move_and_slide()
	update_force(velocity)

func update_force(_velocity) -> void:
	force = _velocity * mass

# handle colision
func _on_touch_body_entered(body) -> void:
	if body.is_in_group("Player") && collision_timer.is_stopped():

		player_state_machine.get_state().collide(body)

func can_wall_jump() -> bool:
	if is_on_wall_only() or ($HorizontalRaycast.is_colliding() or $HorizontalRaycast2.is_colliding() or $HorizontalRaycast3.is_colliding()
	   or $HorizontalRaycast4.is_colliding() or $HorizontalRaycast5.is_colliding() or $HorizontalRaycast6.is_colliding()):
		return true
	else:
		return false

func area_entered(body) -> void:
	if body.is_in_group("item"):
		item_state_machine.set_state(ssg)

	if body.is_in_group("Player"):
		player_state_machine.get_state().collide(body)
		var tempDeaths = body.deaths
		if (kill_timer.is_stopped()):
			kill_timer.start()
			await kill_timer.timeout
			if (body.deaths < tempDeaths):
				kills += 1
				print(kills)
			


func _on_kill_timer_timeout():
	pass # Replace with function body.
