extends StaticBody2D

@export var heal : float = 25.0

func _ready():
	add_to_group("heal")

func get_heal():
	return heal
