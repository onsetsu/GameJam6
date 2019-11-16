extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -450
export (int) var gravity = 1500
export (int) var max_y_velocity = -500
export (float) var friction = 0.8
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

func get_input():
    right = Input.is_action_pressed('right')
    left = Input.is_action_pressed('left')
    jump = Input.is_action_pressed('jump')
    dig = Input.is_action_pressed('dig')
    invert_gravity = Input.is_action_pressed('toggle_gravity')

    old_action = action
    action = jump or dig or invert_gravity #right or left or 
    toggle = false
    if not old_action and action:
        toggle = true

    var floor_ceiling = is_on_floor() or is_on_ceiling()

    if jump and floor_ceiling and toggle:
        velocity.y = jump_speed * gravity_multiplyer
    if jump and not is_on_floor() and abs(velocity.y) < abs(max_y_velocity):
        velocity.y -= 10 * gravity_multiplyer
    
    if not jump and floor_ceiling:
        velocity.x *= friction
    
    if floor_ceiling:
        if right:
            velocity.x = run_speed
        if left:
            velocity.x = -run_speed

    if invert_gravity and toggle:
        gravity_multiplyer *= -1

func _physics_process(delta):
    get_input()
    
    velocity.y += gravity * delta * gravity_multiplyer
        
    if dig:
        position.y += digging_speed * gravity_multiplyer
    else:
        velocity = move_and_slide(velocity, Vector2(0, -1))