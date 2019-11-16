extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Load action container
const prefab_path = "res://Scenes/prefabs/ActionContainer.tscn"
var prefab_scene = preload(prefab_path)
onready var item_prefab = prefab_scene

# List of actions to perform
var actions = []
var index = 0
var active_action = null
#signal actions_changed(actions)
#signal index_changed(index)

# UI list of actions
var list
var list_highlight
var list_items = []


var player
var disabled = false setget set_disabled

func set_actions(actions):
	self.actions = actions
	index = 0
	update_list()

func get_current_action():
	if index >= actions.size(): return 

func update_list():
	for action in actions:
		var item = item_prefab.instance()
		list_items.push_back(item)
		item.get_node("Item").texture = action.image
		list.add_child(item)
	update_indicator()
		
func update_indicator():
	var has_item = index < actions.size()
	list_highlight.color.a = 1 if has_item else 0
	if has_item:
		list_highlight.rect_position = list_items[index].rect_position

func update_items():
	for action_index in range(actions.size()):
		var item = list_items[action_index]
		item.get_node("Item").rect_scale.y = player.gravity_multiplyer

func _process(delta):
	if(disabled):
		return
	if index >= actions.size(): return
	var action = actions[index]
	if Input.is_action_just_pressed("perform_action"):
		activate(action)
		list_highlight.color = Color.green
		update_items()
	elif Input.is_action_just_released("perform_action"):
		deactivate()
		list_highlight.color = Color.white
		update_items()
		index += 1
		update_indicator()

func set_disabled(new_value):
	if new_value: deactivate()
	disabled = new_value

func activate(action):
	active_action = action
	Input.action_press(action.id)
	print("press " + action.id)

func deactivate():
	if !active_action: return
	Input.action_release(active_action.id)
	print("release " + active_action.id)
	active_action = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var list_root = get_node("../ActionList")
	list = list_root.get_node("List")
	list_highlight = list_root.get_node("Highlight")
	player = get_node("../Player")
	update_indicator()
	set_actions(LevelSingleton.get_actions())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
