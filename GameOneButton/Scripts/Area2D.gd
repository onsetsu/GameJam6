extends Area2D

func _on_Area2D_body_entered(body):
	if(body.get("digging_speed") == null):
		return
	LevelSingleton.reset()
