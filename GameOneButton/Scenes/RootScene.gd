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

const debug = false

const scene_path = "res://Actions.tscn"
var actions_scene = preload(scene_path)
onready var actions = actions_scene.instance().get_children()

func _ready():
	if !debug:
		for action in actions:
			InputMap.action_erase_events(action.id)

func _process(delta):
	if Input.is_action_just_released("perform_action") and first:
		LevelSingleton.inPlanningPhase = true
		LevelSingleton.loadScene()
		remove_child($Splash)
		first = false
