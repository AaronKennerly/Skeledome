extends Node

class_name PlayerState

@export var can_move : bool = true
@export var can_jump : bool = true
@export var can_dash : bool = true
@export var can_slide : bool = true


var player : CharacterBody2D
var next_state : PlayerState

func _physics_process(delta):
	pass

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass

func jump():
	player.jump_count += 1
	player.jump_bool = true
	player.velocity.y = player.JUMP_VELOCITY
	

