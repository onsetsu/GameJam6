extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const scene_path = "res://Actions.tscn"
var actions_scene = preload(scene_path)
onready var actions = actions_scene.instance()

func get_actions():
	return actions.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
