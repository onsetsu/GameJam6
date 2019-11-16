extends Area2D

var goalReached = false
var timer = 1.5

func on_body_entered(body):
	if(goalReached):
		return
	if(body.get("digging_speed") == null):
		return
	goalReached = true
	var rect = get_node("Sprite").region_rect
	get_node("Sprite").region_rect = Rect2(rect.position.x, rect.position.y + 128, rect.size.x, rect.size.y)
	print(rect)
	
func _process(delta):
	if(goalReached):
		timer -= delta
		if(timer < 0):
			LevelSingleton.current_level = LevelSingleton.current_level % LevelSingleton.amount_of_levels
			LevelSingleton.current_level += 1
			LevelSingleton.changeScene()
	