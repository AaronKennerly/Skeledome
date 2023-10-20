extends Node

class_name SoundPool

var sounds : Array
var last_index
var index

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in get_children():
		if (child is SoundQueue):
			sounds.append(child)


func play_random():
	
	while index == last_index:
		index = sounds.pick_random()
	
	last_index = index
	index.play_sound()
	
