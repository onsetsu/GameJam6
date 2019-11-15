extends ItemList

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var queuedActions = get_node("../QueuedActions")

const scene_path = "res://Actions.tscn"
var actions_scene = preload(scene_path)
onready var actions = actions_scene.instance().get_children()


# Called when the node enters the scene tree for the first time.
func _ready():
	for action in actions:
		self.add_item(action.id, null, true)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func queue_action(index):
	var selectedAction = actions[index]
	queuedActions.queue(selectedAction)