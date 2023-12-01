extends Node2D

#signals
signal timer(time)

#variables for timer
var time_passed : float = 0.0
var pause_menu

#variable for saving
var checkpoint_reached : bool = false
var ending_reached : bool = false
var globalvariables

func _ready():
	pause_menu = get_node("pause_menu")
	remove_child(pause_menu)
	globalvariables = get_node("/root/Gamevars")
	globalvariables.load_game()
	checkpoint_reached = globalvariables.level1_checkpoint

func _process(delta):
	time_passed += delta
	timer.emit(time_passed)
	if(ending_reached):
		exit()

func pause():
	# do shit before pausing like enabling the pause menu and shi
	add_child(pause_menu)
	get_tree().paused = true

func exit():
	globalvariables.level1_checkpoint = checkpoint_reached
	globalvariables.level1_completed = ending_reached
	globalvariables.save_game()
	ending_reached = false
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")

func _on_pause_menu_unpause():
	remove_child(pause_menu)

func _on_checkpoint_body_entered(_body):
	self.checkpoint_reached = true
