extends StaticBody2D

@export var damage : float = 25.0

func _ready():
	add_to_group("enemy")

func get_dmg():
	return damage
