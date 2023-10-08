extends Node

class_name PlayerState

@export var can_move : bool = true
@export var can_jump : bool = true
@export var can_dash : bool = true
@export var can_slide : bool = true
@export var can_stomp : bool = true
@export var can_cancel : bool = true
@export var can_block : bool = true


var player : Player
var next_state : PlayerState
var height

# constant checks
func _physics_process(_delta) -> void:
	pass

# checks unique for state
func state_process(_delta) -> void:
	pass

# input handled while in state
func state_input(_event : InputEvent) -> void:
	pass

# do when entering state
func on_enter() -> void:
	pass

# do when leaving state
func on_exit() -> void:
	pass

# all Player states have access to the jump function
func jump() -> void:
#	height = player.position.y
	player.jump_count += 1
	player.jump_bool = true
	player.velocity.y = player.JUMP_VELOCITY

# TODO: player bounce
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
	

