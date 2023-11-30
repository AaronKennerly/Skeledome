extends State

class_name PlayerState

@export var can_move : bool = true
@export var can_jump : bool = true
@export var can_dash : bool = true
@export var can_slide : bool = true
@export var can_stomp : bool = true
@export var can_cancel : bool = true
@export var can_block : bool = true
@export var can_dive : bool = true

@onready var air_state = get_node("../AirState")
@onready var block_state = get_node("../BlockState")
@onready var cancel_state = get_node("../CancelState")
@onready var dash_state = get_node("../DashState")
@onready var dive_state = get_node("../DiveState")
@onready var respawn_state = get_node("../RespawnState")
@onready var run_state = get_node("../RunState")
@onready var slide_state = get_node("../SlideState")
@onready var stomp_state = get_node("../StompState")
@onready var stun_state = get_node("../StunnedState")
@onready var wall_state = get_node("../WallState")

var height


# all Player states have access to the jump function
func jump() -> void:
	player.jump_count += 1
	player.jump_bool = true
	player.velocity.y = player.JUMP_VELOCITY

# BUG: game collisions prioritizes player 1. if equal collide, player 2 is bumped
# handle collisions
func collide(body) -> void:
	player.is_colliding = true

	if body.velocity.x == 0:
		body.velocity.x = player.velocity.x * 1.5
	if abs(player.velocity.x) - abs(body.velocity.x) < 100 && (player.velocity.x / body.velocity.x <= 1) && abs(player.velocity.x) >= 100:
		player.velocity.x *= -2
	else:
		player.velocity.x += body.velocity.x
	if (player.velocity.y > body.velocity.y):
		player.velocity.y += min(player.velocity.y - body.velocity.y, 300)
	player.collision_timer.start()
	

