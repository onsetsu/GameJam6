extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var queuedActions

# Called when the node enters the scene tree for the first time.
func _ready():
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
