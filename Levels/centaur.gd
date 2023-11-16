extends StaticBody2D

var arrow = load("res://Levels/arrow.tscn")

var shooting = true
@onready var shot_direction = $Shot_Direction
@onready var firerate = $FireRate

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot()


func shoot():
	shooting = true
	firerate.start()


func _physics_process(delta):
	if (!shooting):
		shoot()

func _on_fire_rate_timeout():
	var spawned_arrow = arrow.instantiate()
	spawned_arrow.directionY = shot_direction.scale.y
	spawned_arrow.directionX = shot_direction.scale.x
	spawned_arrow.global_position = shot_direction.position
	add_child(spawned_arrow)
	
