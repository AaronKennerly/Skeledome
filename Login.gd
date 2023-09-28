extends CanvasLayer

# Get the player and spawn point objects
var spawn1: Node2D
var spawn2: Node2D
var spawn3: Node2D
var player1: Player
var player2: Player
var player3 :Player
var player_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the spawn points
	spawn1 = get_node("Spawnpoint1")
	spawn2 = get_node("Spawnpoint2")
	spawn3 = get_node("Spawnpoint3")
	player1 = get_node("Player1")
	player1.set_physics_process(false)
	player2 = get_node("Player2")
	player2.set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event:InputEvent):
	if event.is_action_pressed("join_1") && !player1.player_joined:  # Change "ui_accept" to the action you want to use
		player1.set_physics_process(true)
		player1.player_joined = true
		player1.SPAWNPOINT = spawn1
		player_count += 1
	elif  event.is_action_pressed("join_2") && !player2.player_joined && player_count == 1:
		player2.set_physics_process(true)
		player2.player_joined = true
		player2.SPAWNPOINT = spawn2
		player_count += 1
	elif event.is_action_pressed("join_3") && player_count == 2:
		player3 = player2.duplicate()
		player3.SPAWNPOINT = spawn3
		player3.position = spawn3.global_position
		player3.set_physics_process(true)
		player3.player_joined = true
		player_count += 1
		# Add the new player as a child to this scene
		add_child(player3)
		player3.set_owner(player3.get_parent())
	elif event.is_action_pressed("start"):
		GameManager.player_count = player_count
		get_tree().change_scene_to_file("res://world.tscn")
