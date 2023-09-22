extends Node2D

var player1
var player2
var endScreen
var gameOver = false
var endText

# Called when the node enters the scene tree for the first time.
func _ready():
	player1 = get_node("Player")
	player2 = get_node("Player2")
	endScreen = get_node("GameOverScreen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player1.dead:
		player2.set_process(false)
		player2.set_physics_process(false)
		endText = "One"
		gameOver = true
	elif player2.dead:
		player1.set_process(false)
		player1.set_physics_process(false)
		endText = "Two"
		gameOver = true
		
	if gameOver:
		endScreen.setText(endText)
		endScreen.visible = true
		endScreen.get_node("PanelContainer/MarginContainer/Rows/CenterContainer/VBoxContainer/QuitButton").disabled = false
		endScreen.get_node("PanelContainer/MarginContainer/Rows/CenterContainer/VBoxContainer/RematchButton").disabled = false
