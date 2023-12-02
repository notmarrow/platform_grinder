extends Control

func _on_button_jugar_pressed():
	get_tree().change_scene_to_file("res://scenes/nivel_1.tscn")


func _on_button_salir_pressed():
	get_tree().quit()


func _on_button_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/nivel_1.tscn")


func _on_button_select_level_pressed():
	get_tree().change_scene_to_file("res://scenes/select_level.tscn")


func _on_button_options_pressed():
	get_tree().change_scene_to_file("res://scenes/opciones.tscn")


func _on_button_creditos_pressed():
	get_tree().change_scene_to_file("res://scenes/credito.tscn")
