extends StaticBody2D

var arrow = load("res://Levels/arrow.tscn")

var shooting = false
const longShotPower = 700.0
var shotPower = 1000.0
var shotCount = 0
@onready var shot_direction = $Shot_Direction
@onready var firerate = $FireRate
@onready var volleyrate = $VolleyTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func shoot():
	firerate.start()


func volley():
	shotPower = longShotPower
	
	while shooting:
		shoot()
		await firerate.timeout


func _physics_process(_delta):
	if (volleyrate.is_stopped() && !shooting):
		print("test")
		volleyrate.start()
		shooting = true
		volley()

func _on_fire_rate_timeout():
	var spawned_arrow = arrow.instantiate()
	spawned_arrow.directionY = shot_direction.scale.y
	spawned_arrow.directionX = shot_direction.scale.x
	spawned_arrow.speed = shotPower
	spawned_arrow.global_position = shot_direction.position
	add_child(spawned_arrow)
	print(shotPower)
	shotPower -= 125.0
	shotCount += 1
	if (shotCount > 4):
		shooting = false
		shotCount = 0
	


func _on_volley_timer_timeout():
	volleyrate.stop()
