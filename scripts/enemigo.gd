extends CharacterBody2D

@export var speed :int = 200
@export var steps :int = 250
@export var current_steps :int = 0

func _ready():
	velocity.x = speed

func _physics_process(delta):
	if current_steps < steps:
		# Mover hacia la derecha
		velocity.x = speed
	else:
		# Giro y mover hacia la izquierda
		velocity.x = -speed

	move_and_slide()

	# Actualizar el número de pasos
	current_steps += 1

	# Reiniciar cuando alcanza el número de pasos máximo
	if current_steps >= steps * 2:
		current_steps = 0
