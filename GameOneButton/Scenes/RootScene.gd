extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var first = true
# Called when the node enters the scene tree for the first time.
#func _process(delta):

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if Input.is_action_just_released("perform_action") and first:
		LevelSingleton.inPlanningPhase = true
		LevelSingleton.loadScene()
		remove_child($Splash)
		first = false
