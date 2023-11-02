extends Node

# Declare a static variable for the spawnpoint
var player_count : int = 0
var level : int = 1
var player_nums : Array = []
var actions : Array = InputMap.get_actions()

# Function to respawn the player
func respawn_player(player):
	if player.SPAWNPOINT != null:
		player.position = player.SPAWNPOINT.global_position

func set_controls():
	var device_nums = Input.get_connected_joypads()
	# loop through the input map any action that ends in i 
	# change its events to the device at i in device_nums
	for i in device_nums.size():
		for n in actions.size():
			if (actions[n].ends_with(str(i+1))):
				var events = InputMap.action_get_events(actions[n])
				for j in events.size():
					events[j].set_device(device_nums[i])
