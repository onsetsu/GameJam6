extends AnimationPlayer

func _ready():
    pass

func _process(delta):
    var vel = get_parent().get("velocity")
    if abs(vel.x) < 10:
        stop()
        pass
    elif not is_playing():
        play("move_right")        
        