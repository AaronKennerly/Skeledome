extends Node

class_name PlayerState

@export var can_move : bool = true

var player : CharacterBody2D
var next_state : PlayerState

func state_input(event : InputEvent):
	pass

func on_enterI():
	pass

func on_exit():
	pass
