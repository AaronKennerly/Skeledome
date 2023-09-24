extends Node

class_name PlayerStateMachine

var states : Array[PlayerState]

@export var player : CharacterBody2D
@export var current_state : PlayerState

func _ready():
	# creating an array of children looking at some modes of state machine
	for child in get_children():
		if (child is PlayerState):
			states.append(child)
				
			# Set the states up with what they need to function
			child.player = player
			
		else:
			push_warning("Child " + child.name +" is not a State for PlayerStateMachine")

# check if state needs to change, else do state process
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	
	current_state.state_process(delta)

# can player move in this state?
func get_can_move():
	return current_state.can_move

func get_state():
	return current_state

# switch states to new_state defined by current_state
func switch_states(new_state : PlayerState):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter()

# handle input
func _input(event : InputEvent):
	current_state.state_input(event)
