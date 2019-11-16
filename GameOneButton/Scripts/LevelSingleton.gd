extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var amount_of_levels = 5
var current_level = 1

var inPlanningPhase = true
var loadedScene
var level_in_background

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_level(parent):
	var scene_path = "res://Scenes/Level%d.tscn" % current_level
	var level_scene = load(scene_path).instance()
	parent.add_child(level_scene)
	parent.move_child(level_scene, 0)
	return level_scene

func get_level():
	var scene_path = "res://Scenes/Level%d.tscn" % current_level
	return load(scene_path).instance()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		changeScene()

func changeScene():
	inPlanningPhase = !inPlanningPhase
	if inPlanningPhase:
		loadedScene.get_node("InputManager").disabled = true
	loadScene()

func reset():
	changeScene()

func loadScene():
	var old_scene = loadedScene
		
	var new_scene
	if(inPlanningPhase):
		new_scene = load("res://Scenes/PlanningPhase.tscn")
		level_in_background = instance_into_root(load("res://Scenes/MainLevel.tscn"))
		level_in_background.get_node("InputManager").disabled = true
	else:
		if(level_in_background != null):		
			remove_node(level_in_background)
		new_scene = load("res://Scenes/MainLevel.tscn")
	
	loadedScene = instance_into_root(new_scene)
	
	if(level_in_background != null):		
		get_tree().get_root().move_child(level_in_background, 0)
	
	
	if(!inPlanningPhase):		
		var queuedActions = old_scene.get_node("QueuedActions")
		loadedScene.get_node("InputManager").set_actions(queuedActions.get_actions());
	
	if(old_scene != null):		
		 remove_node(old_scene)
		
	return loadedScene

func instance_into_root(scene_class):
    var instance = scene_class.instance()
    attach_to_root(instance)
    return instance

func attach_to_root(scene):
    var root = get_tree().get_root()
    root.add_child(scene)

func remove_node(node):
    var parent = node.get_parent()
    if parent:
        parent.remove_child(node)