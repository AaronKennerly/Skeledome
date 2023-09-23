extends CharacterBody2D
class_name Player

# Exported variables
@export var controls: Resource = null
@export var jump_state: PlayerState

@onready var state_machine : PlayerStateMachine = $PlayerStateMachine

# Constants
const SPEED = 300.0
const ACCELERATION = 10.0
const DECELERATION = 20.0
const JUMP_BUFFER_TIME = 0.1
const COYOTE_TIME = 0.2
const JUMP_VELOCITY = -600.0

# Member variables
var coyote_timer = 0.0
var jump_buffer_timer = -10.0
var jump_bool = false
var jump_count = 0

var respawn_timer : Timer
var touch : Area2D
var force : Vector2
var mass = 60.0
var deaths = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
#	touch = $Touch
#	touch._on_body_entered.connect(_on_body_entered)
	respawn_timer = $RespawnTimer
	respawn_timer.timeout.connect(_on_timer_timeout)
	


func _physics_process(delta):
	velocity = get_velocity()

	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	if Input.is_action_just_pressed(controls.jump):
		jump_buffer_timer = JUMP_BUFFER_TIME
	
	# calculating Base Movement
	if state_machine.get_can_move():
		if Input.is_action_pressed(controls.moveLeft):
			if velocity.x > 0:
				velocity.x *= 0.75 #If changing direction, happens slightly faster, feeling better
			velocity.x = max(velocity.x - ACCELERATION, -SPEED)
		elif Input.is_action_pressed(controls.moveRight):
			if velocity.x < 0:
				velocity.x *= 0.75
			velocity.x = min(velocity.x + ACCELERATION, SPEED)
			
		else:
			if velocity.x < 0:
				velocity.x = min(velocity.x + DECELERATION, 0)
			else:
				velocity.x = max(velocity.x - DECELERATION, 0)
	
	set_velocity(velocity)
	move_and_slide()
	update_force(velocity)

func update_force(_velocity):
	force = _velocity * mass



# this function is for when the player falls off the map
func die():
	deaths += 1
	GameManager.respawn_player(self)

func _on_timer_timeout():
	if position.y >= 750 or position.x <= -200 or position.x >= 1350:
		die()

func _on_respawn_timer_timeout():
	pass # Replace with function body.


#func _on_body_entered(body):
#	if body.is_in_group == "Player":
#		velocity.y += body.velocity.y
#		velocity.x += body.velocity.x
#	print("test")
	
	


func _on_touch_body_entered(body):
	if body.is_in_group("Player"):
		velocity.y += body.velocity.y
		velocity.x += body.velocity.x



