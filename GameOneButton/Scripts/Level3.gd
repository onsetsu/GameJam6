extends TileMap

func get_all_actions():
	return ['right', 'jump', 'left']	#Available actions

func get_queue_count():
	return 10