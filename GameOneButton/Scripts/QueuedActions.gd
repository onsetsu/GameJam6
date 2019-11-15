extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var queuedActions

const scene_path = "res://Actions.tscn"
var actions_scene = preload(scene_path)
onready var action_scene = actions_scene.instance().get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_fixed_icon_size(Vector2(64, 64))
	queuedActions = []
	pass # Replace with function body.

func queue(action):	
	self.add_item(action.display_name, action.image, true)
	
func get_actions():
	var actions = []
	for i in range(0, self.get_item_count()):
		actions.push_back(_get_action_with_name(self.get_item_text(i)))
		
	return actions
	

func _get_action_with_name(name):
	for action in action_scene:
		if(action.display_name == name):
			return action
	return null


func remove_action():
	for selected_item in self.get_selected_items():
		self.remove_item(selected_item)

func move_up_action():
	for selected_item in self.get_selected_items():
		self.move_item(selected_item, (selected_item - 1 + self.get_item_count()) % self.get_item_count())

func move_down_action():
	for selected_item in self.get_selected_items():
		self.move_item(selected_item, (selected_item + 1) % self.get_item_count())
