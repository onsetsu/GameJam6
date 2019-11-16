extends TileMap


func get_all_actions():
	return ['left', 'dig', 'jump', 'toggle_gravity']	#Available actions

func get_queue_count():
	return 6