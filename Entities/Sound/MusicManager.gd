extends Node

var main_menu = load("res://Assets/Music/Si tu savais (90 bpm) - Gypsy jazz Backing track Jazz manouche [TubeRipper.com].ogg")
var game = load("res://Assets/Music/Douce ambiance (170 bpm) - Gypsy jazz Backing track Jazz manouche [TubeRipper.com].ogg")

var song_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_main_menu():
	$Music.stream = main_menu
	$Music.play()
	song_name = "main_menu"

func play_game():
	$Music.stream = game
	$Music.play()
	song_name = "game"
