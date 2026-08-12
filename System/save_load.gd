extends Node

var file_path: String = "user://SaveFile.json"

var save_data: SaveNewData = SaveNewData.new()


func _ready() -> void:
	_load()


## Function to save game
func _save() -> void:
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	
	var data_to_save := {
		"player_location": save_data.player_location
	}
	
	var json_var := JSON.stringify(data_to_save)
	
	file.store_string(json_var)
	file.close()


## Function to load previous game data
func _load() -> void:
	if FileAccess.file_exists(file_path):
		var file := FileAccess.open(file_path, FileAccess.READ)
		var saved_data = JSON.parse_string(file.get_as_text())
		file.close()
		
		save_data = SaveNewData.new()
		save_data.player_location = saved_data.player_location
