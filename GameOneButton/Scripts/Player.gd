extends KinematicBody2D

var idle_particles = preload('res://Scenes/IdleParticles.tscn')
var jump_particles = preload('res://Scenes/JumpParticles.tscn')

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

var sound_jump
var sound_land
var sound_dig
var sound_toggle_gravity
var sound_walk

var was_walking = false
var was_grounded = true

func _ready():
	add_child(idle_particles.instance())
	sound_jump = $jump
	sound_land = $land
	sound_dig = $dig1
	sound_toggle_gravity = $toggle_gravity
	sound_walk = $walk1

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
		sound_jump.play()
		add_child(jump_particles.instance())
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
	
	var pos = position
	move_and_collide(Vector2())
	if pos.x != position.x or pos.y != position.y:
		position.x = pos.x
		position.y = pos.y - 10 #temporary offset
		set_collision_mask(2)
		set_collision_layer(2)

	var is_grounded = is_on_floor() if gravity_multiplyer > 0 else is_on_ceiling()
	if !was_grounded and is_grounded:
		sound_land.play()
	was_grounded = is_grounded

	if invert_gravity and toggle:
		gravity_multiplyer *= -1
		if gravity_multiplyer == 1:
			get_node("PlayerSprite").set_flip_v(false)
		else:
			get_node("PlayerSprite").set_flip_v(true)

func _on_collision(value):
	print("test")

func handle_sound():
	if Input.is_action_just_pressed("dig"):
		sound_dig.play()
	elif Input.is_action_just_released("dig"):
		sound_dig.stop()
	
	if Input.is_action_just_pressed("toggle_gravity"):
		sound_toggle_gravity.play()
	
	var is_walking = (left or right) and was_grounded
	if !was_walking and is_walking:
		sound_walk.play()
	elif was_walking and !is_walking:
		sound_walk.stop()
	was_walking = is_walking

func _physics_process(delta):
	if Input.is_action_just_released("restart"):
		LevelSingleton.reset()
	get_input()
	handle_sound()
	
	velocity.y += gravity * delta * gravity_multiplyer
	
	var last_x_velocity = velocity.x
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if is_on_wall():
		velocity.x = last_x_velocity*vertical_friction
