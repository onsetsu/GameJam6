extends TileMap

func get_all_actions():
	return ['right', 'left','jump']	#Available actions

func get_queue_count():
	return 5