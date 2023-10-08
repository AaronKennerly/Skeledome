extends Timer

class_name CollisionTimer

@export var player : Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass


func _on_timeout() -> void:
	player.is_colliding = false
