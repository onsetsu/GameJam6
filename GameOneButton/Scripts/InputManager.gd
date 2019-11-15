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
	if Input.is_action_just_pressed("ui_accept"):
		Input.action_press(actions[index].id)
	elif Input.is_action_just_released("ui_accept"):
		Input.action_release(actions[index].id)
		index += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
