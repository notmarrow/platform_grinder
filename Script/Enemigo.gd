extends CharacterBody2D

var SPEED = 200
var steps_to_move_right = 250 # Ajusta este valor según tus necesidades
var current_steps = 0

func _ready():
	velocity.x = SPEED

func _physics_process(delta):
	if current_steps < steps_to_move_right:
		# Mover hacia la derecha
		velocity.x = SPEED
	else:
		# Giro y mover hacia la izquierda
		velocity.x = -SPEED

	move_and_slide()

	# Actualizar el número de pasos
	current_steps += 1

	# Reiniciar cuando alcanza el número de pasos máximo
	if current_steps >= steps_to_move_right * 2:
		current_steps = 0
