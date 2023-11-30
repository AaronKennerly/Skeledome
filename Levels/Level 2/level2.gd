extends Node2D

var players : Array = []
var endScreen : CanvasLayer
var gameOver = false
var endText : String
var count : int = GameManager.player_count
var player_vals : Array = GameManager.player_nums
var numWords : Array = ["One", "Two", "Three", "Four"]
var seconds : int
var minutes : int

@onready var windStart : Timer = $WindStartTimer
@onready var windEnd : Timer = $WindEndTimer
@onready var timeLabel : Label = $UI/Label
@onready var wind : Node2D = $Wind

# Called when the node enters the scene tree for the first time.
func _ready():
	if MusicManager.song_name != "game":
		MusicManager.play_game()
	#player1 = get_node("Player1")
	for i in count:
		var player = get_node("Player" + str(player_vals[i]))
		player.player_joined = true
		player.dead = false
		player.kills = GameManager.player_kills[i]
		player.wins = GameManager.player_wins[i]
		player.position = player.SPAWNPOINT.global_position
		player.SPAWNPOINT = get_node("Respawn")
		players.append(player)
	
	wind.setWind(false)
	wind.set_process(false)
	endScreen = get_node("GameOverScreen")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# update the timer at the top of the screen
	if (windEnd.is_stopped()):
		minutes = int(windStart.time_left / 60.0)
		seconds = int(fmod(windStart.time_left, 60.0))
		timeLabel.text = "Next Wind Storm in\n"
	else:
		minutes = int(windEnd.time_left / 60.0)
		seconds = int(fmod(windEnd.time_left, 60.0))
		timeLabel.text = "Wind Stops in\n"

	# set the labels time
	if (seconds < 10):
		timeLabel.text += str(minutes) + ":0" + str(seconds)
	else:
		timeLabel.text += str(minutes) + ":" + str(seconds)
	
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
			GameManager.player_kills[i] = players[i].kills
			if (!players[i].dead):
				players[i].set_process(false)
				players[i].set_physics_process(false)
				players[i].wins += 1
				endText = numWords[i]
			GameManager.player_wins[i] = players[i].wins
			
		endScreen.setText(endText)
		endScreen.visible = true
		endScreen.get_node("PanelContainer/MarginContainer/Rows/CenterContainer/VBoxContainer/QuitButton").disabled = false
		endScreen.get_node("PanelContainer/MarginContainer/Rows/CenterContainer/VBoxContainer/RematchButton").disabled = false
		get_tree().paused = true


func _on_wind_start_timer_timeout():
	windEnd.start()
	wind.set_process(true)
	wind.setWind(true)


func _on_wind_end_timer_timeout():
	windStart.start()
	wind.setWind(false)
	wind.set_process(false)
