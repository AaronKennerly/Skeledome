extends Node

class_name PlayerState

@export var can_move : bool = true
@export var can_jump : bool = true
@export var can_dash : bool = true
@export var can_slide : bool = true
@export var can_stomp : bool = true


var player : CharacterBody2D
var next_state : PlayerState
var height

# constant checks
func _physics_process(_delta):
	pass

# checks unique for state
func state_process(_delta):
	pass

# input handled while in state
func state_input(_event : InputEvent):
	pass

# do when entering state
func on_enter():
	pass

# do when leaving state
func on_exit():
	pass

# all Player states have access to the jump function
func jump():
#	height = player.position.y
	player.jump_count += 1
	player.jump_bool = true
	player.velocity.y = player.JUMP_VELOCITY

# TODO: player bounce
# BUG: game collisions prioritizes player 1. if equal collide, player 2 is bumped
# handle collisions
func collide(body):
	if abs(player.velocity.x) - abs(body.velocity.x) < 100:
		player.velocity.x *= -2
	player.velocity.x += body.velocity.x
	player.velocity.y += body.velocity.y

