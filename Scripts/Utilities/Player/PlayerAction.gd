extends Node

class_name PlayerAction

signal pressed
signal released
signal handling

@export var action = ""

# filters out unwanted action and handles it if it's a valid action
func _unhandled_input(event) -> void:
	if !event.is_action_type():
		return
	if event.is_echo():
		return
	if !event.is_action(action):
		return
	handle_input(event)

# handle input by emiting the relevant signal
func handle_input(event) -> void:
	emit_signal("handling")
	if event.is_pressed():
		emit_signal("pressed")
	else:
		emit_signal("released")

# is the action being held?
func is_holding() -> bool:
	var holding = false
	if Input.is_action_pressed(action):
		holding = true
		emit_signal("handling")
		emit_signal("pressed")
	return holding
