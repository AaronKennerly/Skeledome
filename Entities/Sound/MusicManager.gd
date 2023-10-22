extends Node

var main_menu = load("res://Assets/Music/Si tu savais (90 bpm) - Gypsy jazz Backing track Jazz manouche [TubeRipper.com].ogg")
var game = load("res://Assets/Music/Douce ambiance (170 bpm) - Gypsy jazz Backing track Jazz manouche [TubeRipper.com].ogg")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_main_menu():
	$Music.stream = main_menu
	$Music.play()

func play_game():
	$Music.stream = game
	$Music.play()
