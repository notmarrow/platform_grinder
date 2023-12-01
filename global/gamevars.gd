extends Node

var selection_checkpoint : bool = false # variable to handle level selection from checkpoint in level selector
var level1_checkpoint : bool
var level1_completed : bool

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		level1_checkpoint = false
		level1_completed = false
	else:
		var save_gamev = FileAccess.open("user://savegame.save", FileAccess.READ)
		while save_gamev.get_position() < save_gamev.get_length():
			var save_json = save_gamev.get_line()
			var json = JSON.new()
			var _parse_result = json.parse(save_json)
			var data = json.get_data()
			
			level1_checkpoint = data.level1_checkpoint
			level1_completed = data.level1_completed
	
func save_game():
	var save_dict = {
		"level1_checkpoint" : level1_checkpoint,
		"level1_completed" : level1_completed
	}
	
	var save_gamev = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_json = JSON.stringify(save_dict)
	
	save_gamev.store_line(save_json)

func print_save():
	print(level1_checkpoint)
	print(level1_completed)
