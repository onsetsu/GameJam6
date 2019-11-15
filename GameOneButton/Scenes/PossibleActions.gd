extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var inputManager = get_node("../InputManager")
onready var queuedActions = get_node("../QueuedActions")
var actions

# Called when the node enters the scene tree for the first time.
func _ready():
	actions = inputManager.get_actions()
	for action in actions:
		self.add_item(action.id, null, true)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func queue_action(index):
	var selectedAction = actions[index]
	queuedActions.queue(selectedAction)