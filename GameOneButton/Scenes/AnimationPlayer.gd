extends AnimationPlayer

var old_vel_y = 0
var vel = Vector2()

func _ready():
	pass

func _process(delta):
	var mult = get_parent().gravity_multiplyer
	old_vel_y = vel.y
	vel = get_parent().get("velocity")*mult
	var on_floor = get_parent().was_grounded
	if abs(vel.x) < 10 and on_floor:
		stop()
	elif not is_playing():
		play("move_right")
	
	if vel.y < 0 and old_vel_y >= 0:
		get_node("../JumpingSprites").show()
		get_node("../WalkingSprites").hide()
		get_node("../FallingSprites").hide()
		play("jump_up")
	elif vel.y > 0 and old_vel_y <= 0:
		get_node("../FallingSprites").show()
		get_node("../WalkingSprites").hide()
		get_node("../JumpingSprites").hide()
		play("falling_down")
	elif on_floor:
		get_node("../WalkingSprites").show()
		get_node("../JumpingSprites").hide()
		get_node("../FallingSprites").hide()