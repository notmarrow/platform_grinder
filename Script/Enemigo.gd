extends CharacterBody2D

var SPEED = 200
var steps_to_move_right = 50  # Ajusta estos valores según tus necesidades
var steps_to_move_left = 50
var current_steps = 0
var moving_right = true

func _ready():
	velocity.x = SPEED

func _physics_process(delta):
	if moving_right:
		velocity.x = SPEED
	else:
		velocity.x = -SPEED

	move_and_slide()

	# Actualizar el número de pasos
	current_steps += 1

	# Cambiar de dirección cuando alcance el número de pasos máximo
	if current_steps >= steps_to_move_right + steps_to_move_left:
		current_steps = 0
		moving_right = not moving_right
