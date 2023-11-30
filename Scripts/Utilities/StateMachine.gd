extends Node

class_name StateMachine

var states : Array[State]

@export var player : Player
@export var current_state : State

func _ready() -> void:
	# creating an array of children looking at some modes of state machine
	for child in get_children():
		if (child is State):
			states.append(child)
				
			# Set the states up with what they need to function
			child.player = player
			
		else:
			push_warning("Child " + child.name +" is not a State for StateMachine")

# check if state needs to change, else do state process
func _physics_process(delta) -> void:
	if(current_state.next_state != null):
		set_state(current_state.next_state)
	
	current_state.state_process(delta)

func get_state() -> State:
	return current_state

# switch states to new_state defined by current_state
func set_state(new_state : State) -> void:
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter()

# handle input
func _input(event : InputEvent) -> void:
	current_state.state_input(event)
