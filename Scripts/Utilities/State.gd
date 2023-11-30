extends Node

class_name State


var player : Player
var next_state : State


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
