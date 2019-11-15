extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		var game_scene = load("res://Scenes/TestMap.tscn")
		var executePhase = instance_into_root(game_scene)
		print(executePhase)
		remove_node(self)
		#get_tree().change_scene("res://Scenes/TestMap.tscn")
		#var tm = get_tree().get_root().get_node("TestMap")
		#print(tm)

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

