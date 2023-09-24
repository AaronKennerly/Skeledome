extends Node

class_name PlayerState

@export var can_move : bool = true
@export var can_jump : bool = true
@export var can_dash : bool = true
@export var can_slide : bool = true


var player : CharacterBody2D
var next_state : PlayerState

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
	player.jump_count += 1
	player.jump_bool = true
	player.velocity.y = player.JUMP_VELOCITY
	
