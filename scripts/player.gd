extends CharacterBody2D

#movement variables
@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = -40.0
@export var DASH_SPEED : float = 300.0

var canDash = true
var impulse = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var input_delay = 0.5

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		canDash = true

	if Input.is_action_pressed("space") and is_on_floor():
		impulse += JUMP_VELOCITY
		
	if Input.is_action_just_released("space") and is_on_floor():
		if impulse < -900:
			impulse = -900
		velocity.y = impulse
		impulse = 0.0

	var direction = Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("click") and canDash:
		canDash = false
		position.x += direction * DASH_SPEED

	move_and_slide()

