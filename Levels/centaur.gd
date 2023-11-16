extends StaticBody2D

var arrow = load("res://Levels/arrow.tscn")

var shooting = true
var longShotPower = 900.0
var shotPower = 1000.0
@onready var shot_direction = $Shot_Direction
@onready var firerate = $FireRate

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot()


func shoot():
	shooting = true
	firerate.start()


func volley():
	shotPower = longShotPower
	
	while(shotPower > 400.0):
		if(!shooting):
			shoot()


func _physics_process(_delta):
	if (shooting):
		print("test")

func _on_fire_rate_timeout():
	var spawned_arrow = arrow.instantiate()
	spawned_arrow.directionY = shot_direction.scale.y
	spawned_arrow.directionX = shot_direction.scale.x
	spawned_arrow.speed = shotPower
	spawned_arrow.global_position = shot_direction.position
	add_child(spawned_arrow)
	shotPower -= 150.0
	shooting = false
	
