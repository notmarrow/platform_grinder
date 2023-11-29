extends Control

signal unpause

func _on_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_button_pressed():
	get_tree().paused = false
	unpause.emit()
