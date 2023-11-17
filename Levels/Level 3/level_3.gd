extends Node2D

var players : Array = []
var endScreen : CanvasLayer
var gameOver = false
var endText : String
var count : int = GameManager.player_count
var player_vals : Array = GameManager.player_nums
var numWords : Array = ["One", "Two", "Three", "Four"]
var arrowCycle = 1
@onready var centaurL = $Centaur
@onready var centaurR = $Centaur2
@onready var arrowTimer = $ArrowTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	if MusicManager.song_name != "game":
		MusicManager.play_game()
	#player1 = get_node("Player1")
	for i in count:
		var player = get_node("Player" + str(player_vals[i]))
		player.player_joined = true
		player.position = player.SPAWNPOINT.global_position
		player.SPAWNPOINT = get_node("Respawn")
		players.append(player)
		
	arrowTimer.start()
	endScreen = get_node("GameOverScreen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# check how many players are dead if the number is 1 less 
	# than the total we have a winner
	var players_dead : int = 0
	for i in count:
		if (players[i].dead):
			players_dead += 1
		if (players_dead == count - 1):
			gameOver = true
		
	if gameOver:
		for i in count:
			if (!players[i].dead):
				players[i].set_process(false)
				players[i].set_physics_process(false)
				endText = numWords[i]
			
		endScreen.setText(endText)
		endScreen.visible = true
		endScreen.get_node("PanelContainer/MarginContainer/Rows/CenterContainer/VBoxContainer/QuitButton").disabled = false
		endScreen.get_node("PanelContainer/MarginContainer/Rows/CenterContainer/VBoxContainer/RematchButton").disabled = false


# this func will make the centaurs shoot at the players
func _on_arrow_timer_timeout():
	centaurL.shooting = true
	centaurR.shooting = true
	
	if (arrowCycle == 1):
		centaurL.volley()
		centaurR.lowShot()
		arrowCycle = 2
	elif (arrowCycle == 2):
		centaurL.lowShot()
		centaurR.volley()
		arrowCycle = 1
