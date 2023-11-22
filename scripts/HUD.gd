extends Control

#nodes
var time_label
var powerup1_texture
var powerup2_texture
var powerup3_texture
var health_bar

func _ready():
	time_label = get_node("CanvasLayer/Cronometro/Tiempo")
	powerup1_texture = get_node("CanvasLayer/ContenedorPowerUPs/PowerUP1")
	powerup2_texture = get_node("CanvasLayer/ContenedorPowerUPs/PowerUP2")
	powerup3_texture = get_node("CanvasLayer/ContenedorPowerUPs/PowerUP3")
	health_bar = get_node("CanvasLayer/Vida")

func update_health(health):
	health_bar.value = health

func update_powerup1(status):
	pass

func update_powerup2(status):
	pass
	
func update_powerup3(status):
	pass

func update_clock(time):
	var s : float = fmod(time, 60.0)
	var m : int = int(time / 60.0) % 60
	var h : int = int(time / 3600.0)
	
	var formatted_time = "%02d:%02d:%05.2f" % [h, m, s]
	
	time_label.text = formatted_time
