extends Node2D

#signals
signal timer(time)

#variables for timer
var time_passed : float = 0.0
var pause_menu

func _ready():
	pause_menu = get_node("pause_menu")
	remove_child(pause_menu)

func _process(delta):
	time_passed += delta
	timer.emit(time_passed)

func pause():
	# do shit before pausing like enabling the pause menu and shi
	add_child(pause_menu)
	get_tree().paused = true


func _on_pause_menu_unpause():
	remove_child(pause_menu)
