extends Label

var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/level_3/Player4")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.deaths == 0:
		text = "Player 4 Out"
	else:
		text = "Player 4\n Lives: " + str(player.deaths)
		
	if player.player_joined && !self.visible:
		self.visible = true
