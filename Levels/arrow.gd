extends Node2D

var direction
var speed = 300.0
var colide = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	

func die():
	colide = true
	speed = true
	$AnimationPlayer.play("death")
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.velocity = velocity * 3
	
	die()
