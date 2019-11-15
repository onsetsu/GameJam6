extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var amount_of_levels = 3
var current_level = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_level(parent):
	var scene_path = "res://Scenes/Level%d.tscn" % current_level
	var level_scene = load(scene_path).instance()
	parent.add_child(level_scene)
	
func get_level():
	var scene_path = "res://Scenes/Level%d.tscn" % current_level
	return load(scene_path).instance()
