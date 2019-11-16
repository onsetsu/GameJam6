extends ParallaxBackground

var scroll_x = 0
onready var player = get_node("../Player")

func _process(delta):	
	# Scroll background
	scroll_x -= 200 * delta
	scroll_offset.x = -player.position.x