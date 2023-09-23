extends PlayerState

class_name RespawnState

func on_enter():
	respawn_timer = $RespawnTimer
	respawn_timer.timeout.connect(_on_timer_timeout)
	
