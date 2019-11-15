extends TileMap

func get_all_actions():
	return ['right', 'left','jump', 'dig', 'toggle_gravity']	#Available actions

func get_queue_count():
	return