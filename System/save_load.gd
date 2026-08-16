extends Node

# Save load script

signal file_exists

var file_path: String = "user://SaveFile.json"

var save_data: SaveNewData = SaveNewData.new()


func _ready() -> void:
	_load_game()


## Function to save game
func _save_game() -> void:
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	
	var data_to_save := {
		"player_location": save_data.player_location,
		"current_level": save_data.current_level,
		"level_state": save_data.level_state,
	}
	
	var json_var := JSON.stringify(data_to_save)
	
	file.store_string(json_var)
	file.close()


## Function to load previous game data
func _load_game() -> void:
	if FileAccess.file_exists(file_path):
		file_exists.emit()
		var file := FileAccess.open(file_path, FileAccess.READ)
		var saved_data = JSON.parse_string(file.get_as_text())
		file.close()
		
		save_data = SaveNewData.new()
		save_data.player_location = saved_data["player_location"]
		save_data.current_level = saved_data["current_level"]
		save_data.level_state = saved_data["level_state"]


## Function to reset game data
func _reset_game() -> void:
	if not FileAccess.file_exists(file_path):
		return
	
	save_data = SaveNewData.new()
	
	var data_to_save = {
		"player_location": save_data["player_location"],
		"current_level": save_data["current_level"],
		"level_state":  save_data["level_state"]
	}
	
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	
	file.store_string(JSON.stringify(data_to_save))
	file.close()


func is_data_exist() -> bool:
	if save_data["player_location"]:
		return true
	
	return false
