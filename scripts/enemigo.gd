extends StaticBody2D

@export var speed :int = 200
@export var steps :int = 250
var current_steps :int = 0

func _ready():
	pass

func _physics_process(delta):
	if current_steps < steps:
		# Mover hacia la derecha
		position.x += speed * delta
	else:
		# Giro y mover hacia la izquierda
		position.x -= speed * delta

	# Actualizar el número de pasos
	current_steps += 1

	# Reiniciar cuando alcanza el número de pasos máximo
	if current_steps >= steps * 2:
		current_steps = 0
