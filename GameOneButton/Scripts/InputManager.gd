extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var actions = []
var index = 0

func set_actions(actions):
	self.actions = actions

func _process(delta):
	if index >= actions.size(): return
	var action = actions[index].id
	if Input.is_action_just_pressed("perform_action"):
		Input.action_press(action)
		print("press " + action)
	elif Input.is_action_just_released("perform_action"):
		Input.action_release(action)
		print("release " + action)
		index += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
