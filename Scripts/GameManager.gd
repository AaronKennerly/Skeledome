extends Node

# Declare a static variable for the spawnpoint
var player_count : int = 0
var player_nums : Array = []

# Function to respawn the player
func respawn_player(player):
	if player.SPAWNPOINT != null:
		player.position = player.SPAWNPOINT.global_position
