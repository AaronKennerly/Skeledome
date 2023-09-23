extends Node

# Declare a static variable for the spawnpoint
var spawnpoint : Node = null

# Function to respawn the player
func respawn_player(player):
	if spawnpoint != null:
		player.position = spawnpoint.global_position
