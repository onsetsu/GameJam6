extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -450
export (int) var gravity = 1500
export (int) var max_y_velocity = -500
export (float) var friction = 0.8
export (float) var vertical_friction = 0.9
export (int) var digging_speed = 5

#active action
var right = false
var left = false
var jump = false
var dig = false
var invert_gravity = false;

var velocity = Vector2()
var gravity_multiplyer = 1

var action = false
var old_action = false
var toggle = false
var frames_since_last_action = 0

func get_input():
    right = Input.is_action_pressed('right')
    left = Input.is_action_pressed('left')
    jump = Input.is_action_pressed('jump')
    dig = Input.is_action_pressed('dig')
    invert_gravity = Input.is_action_pressed('toggle_gravity')

    old_action = action
    action = jump or dig or invert_gravity or right or left
    toggle = false
    if not old_action and action:
        toggle = true
    
    if not action:
        frames_since_last_action += 1
    else:
        frames_since_last_action = 0

    var floor_ceiling = is_on_floor() or is_on_ceiling()

    if jump and floor_ceiling and toggle:
        velocity.y = jump_speed * gravity_multiplyer
    if jump and not is_on_floor() and abs(velocity.y) < abs(max_y_velocity):
        velocity.y -= 10 * gravity_multiplyer
    
    if not jump and floor_ceiling and frames_since_last_action > 10:
        velocity.x *= friction
    
    if jump and not toggle and floor_ceiling:
        velocity.x = 0
            
    if floor_ceiling:
        if right:
            velocity.x = run_speed
            get_node("PlayerSprite").set_flip_h(false)
        if left:
            velocity.x = -run_speed
            get_node("PlayerSprite").set_flip_h(true)
            
    if dig and toggle:
        set_collision_mask(2)
        set_collision_layer(2)
    elif not dig:
        set_collision_mask(1) 
        set_collision_layer(1)

    if invert_gravity and toggle:
        gravity_multiplyer *= -1
        if gravity_multiplyer == 1:
            get_node("PlayerSprite").set_flip_v(false)
        else:
            get_node("PlayerSprite").set_flip_v(true)

func _physics_process(delta):
    if Input.is_action_just_pressed("restart"):
        LevelSingleton.reset()
    get_input()
    
    velocity.y += gravity * delta * gravity_multiplyer
    
    var last_x_velocity = velocity.x
    velocity = move_and_slide(velocity, Vector2(0, -1))
    if is_on_wall():
        velocity.x = last_x_velocity*vertical_friction