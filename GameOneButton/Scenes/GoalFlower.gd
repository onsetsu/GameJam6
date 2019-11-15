extends Area2D


func on_body_entered(body):
	if(body.get("digging_speed") == null):
		return
	LevelSingleton.current_level = LevelSingleton.current_level % LevelSingleton.amount_of_levels
	LevelSingleton.current_level += 1
	var planning_scene = load("res://Scenes/PlanningPhase.tscn")
	instance_into_root(planning_scene)
	remove_node(self)

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
