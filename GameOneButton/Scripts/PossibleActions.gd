extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var queuedActions = get_node("../QueuedActions")

const scene_path = "res://Actions.tscn"
var actions_scene = preload(scene_path)
onready var action_scene = actions_scene.instance().get_children()


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_fixed_icon_size(Vector2(64, 64))
	for action_id in LevelSingleton.get_level().get_all_actions():
		var action = _get_action_with_id(action_id)
		self.add_item(action.display_name, action.image, true)

func _get_action_with_id(id):
	for action in action_scene:
		if(action.id == id):
			return action
	return null
	
func _get_action_with_name(name):
	for action in action_scene:
		if(action.display_name == name):
			return action
	return null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func queue_action(index):
	var selectedAction = _get_action_with_name(self.get_item_text(index))
	queuedActions.queue(selectedAction)