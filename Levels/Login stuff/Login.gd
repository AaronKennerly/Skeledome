extends CanvasLayer

# Get the player and spawn point objects
var spawn1: Node2D
var spawn2: Node2D
var spawn3: Node2D
var spawn4: Node2D
var player_count: int = 0
var players : Array = []
var player_nums : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 4:
		var player = get_node("Player" + str(i + 1))
		player.player_joined = false
		player.set_physics_process(false)
		player.SPAWNPOINT = get_node("Spawnpoint" + str(i + 1))
		players.append(player)
		
	GameManager.set_controls()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass

func _input(event:InputEvent) -> void:
	for i in 4:
		if players[i] != null && event.is_action_pressed("join_" + str(i + 1)) && !players[i].player_joined :
			players[i].set_physics_process(true)
			players[i].player_joined = true
			player_count += 1
			player_nums.append(i + 1)
			return
	
	if event.is_action_pressed("start_1") && player_count >= 2:
		GameManager.player_count = player_count
		GameManager.player_nums = player_nums
		get_tree().change_scene_to_file("res://Levels/testing world/world.tscn")
