extends KinematicBody2D

export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200
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
    right = Input.is_action_pressed('ui_right')
    left = Input.is_action_pressed('ui_left')
    jump = Input.is_action_pressed('ui_select')
    dig = Input.is_key_pressed(KEY_D)
    invert_gravity = Input.is_key_pressed(KEY_G)

    old_action = action
    action = right or left or jump or dig or invert_gravity
    toggle = false
    if not old_action and action:
        toggle = true

    if jump and (is_on_floor() or is_on_ceiling()):
        velocity.y = jump_speed * gravity_multiplyer
    if jump and not is_on_floor() and abs(velocity.y) < abs(max_y_velocity):
        velocity.y -= 10 * gravity_multiplyer
    
    if is_on_floor() or is_on_ceiling():
        velocity.x *= friction
        if right:
            velocity.x += run_speed
        if left:
            velocity.x -= run_speed

    if invert_gravity and toggle:
        gravity_multiplyer *= -1

func _physics_process(delta):
    get_input()
    
    velocity.y += gravity * delta * gravity_multiplyer
        
    if dig:
        position.y += digging_speed
    else:
        velocity = move_and_slide(velocity, Vector2(0, -1))