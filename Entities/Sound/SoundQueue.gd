extends Node

class_name SoundQueue

@export var count : int

var next : int = 0
var audio_stream_players : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# catch edge cases
	if get_child_count() == 0:
		push_warning("No children found. Expected one AudioStreamPlayer child.")
	
	if !(get_child(0) is AudioStreamPlayer):
		push_warning("Expected first child to be an AudioStreamPlayer")
	
	# add first child to array if child is an AudioStreamPlayer
	var child = get_child(0)
	if child is AudioStreamPlayer:
		audio_stream_players.append(child)
		
		# add remaining children
		for n in count:
			var copy : AudioStreamPlayer = child.duplicate() as AudioStreamPlayer
			add_child(copy)
			audio_stream_players.append(copy)
			
func play_sound() -> void:
	if !audio_stream_players[next].is_playing():
		audio_stream_players[++next].play()
		next %= count
