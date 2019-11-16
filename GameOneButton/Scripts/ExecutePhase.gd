extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var lvl = LevelSingleton.load_level(self)
	var point = lvl.get_node('Spawnpoint')
	var player =lvl.get_parent().get_node('Player')
	print(player)
	print(point)
	player.set_position(point.get_global_position())
