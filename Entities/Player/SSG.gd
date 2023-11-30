extends ItemState

class_name None

func on_enter():
	hand.texture = ssg_sprite
	hand.scale = Vector2(0.02,0.02)

func action():
	aim = hand.global_position
	player.velocity = player.position.direction_to(aim) * -1900

func throw():
	pass
