extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var queuedActions

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_fixed_icon_size(Vector2(64, 64))
	queuedActions = []
	pass # Replace with function body.

func queue(action):	
	queuedActions.push_back(action);
	self.add_item(action.display_name, action.image, true)
	
func get_actions():
	return queuedActions
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func remove_action():
	for selected_item in self.get_selected_items():
		self.remove_item(selected_item)

func move_up_action():
	for selected_item in self.get_selected_items():
		self.move_item(selected_item, (selected_item - 1 + self.get_item_count()) % self.get_item_count())

func move_down_action():
	for selected_item in self.get_selected_items():
		self.move_item(selected_item, (selected_item + 1) % self.get_item_count())
