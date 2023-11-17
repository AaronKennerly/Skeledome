extends StaticBody2D

var arrow = load("res://Levels/arrow.tscn")

var shooting : bool = false
const longShotPower : float = 700.0
var shotPower : float = 1000.0
var shotCount : int = 0
var shotType : int = 0
@onready var shot_direction = $Shot_Direction
@onready var firerate = $FireRate

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func shoot():
	firerate.start()


func volley():
	shotPower = longShotPower
	shotType = 2
	while shooting:
		shoot()
		await firerate.timeout


func lowShot():
	shotPower = longShotPower * 4
	shotType = 1
	shoot()

func _on_fire_rate_timeout():
	var spawned_arrow = arrow.instantiate()
	if (shotType == 1):
		spawned_arrow.yHeight = 15.0
		spawned_arrow.gravity = 0.0
		spawned_arrow.directionY = shot_direction.scale.y
	else :
		spawned_arrow.directionY = shot_direction.scale.y
	spawned_arrow.directionX = shot_direction.scale.x
	spawned_arrow.speed = shotPower
	spawned_arrow.global_position = shot_direction.position
	add_child(spawned_arrow)
	if (shotType == 1):
		shooting = false
		shotCount = 0
	else:
		shotPower -= 125.0
		shotCount += 1
		if (shotCount > 4):
			shooting = false
			shotCount = 0
