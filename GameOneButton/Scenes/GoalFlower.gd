extends Area2D


func on_body_entered(body):
	if(body.get("digging_speed") == null):
		return
	LevelSingleton.current_level = LevelSingleton.current_level % LevelSingleton.amount_of_levels
	LevelSingleton.current_level += 1
	LevelSingleton.changeScene()
	