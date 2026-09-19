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
	
	var weapon_path: Array[String] = []
	
	for weapon in save_data.weapon_collection:
		weapon_path.append(weapon.resource_path)
	
	var data_to_save := {
		"player_location": save_data.player_location,
		"player_health": save_data.player_health,
		"current_level": save_data.current_level,
		"level_state": save_data.level_state,
		"coin_collected": save_data.coin_collected,
		"current_checkpoint": save_data.current_checkpoint,
		"weapon_collection": weapon_path,
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
		save_data.player_location = saved_data.get("player_location", {})
		save_data.player_health = saved_data.get("player_health", {})
		save_data.current_level = saved_data.get("current_level", 1)
		save_data.level_state = saved_data.get("level_state", {})
		save_data.coin_collected = saved_data.get("coin_collected", [])
		save_data.current_checkpoint = saved_data.get("current_checkpoint", "")
		_load_weapon_collection(saved_data)


## Function to reset game data
func _reset_game() -> void:
	if not FileAccess.file_exists(file_path):
		return
	
	## Created an empty box
	save_data = SaveNewData.new()
	
	var data_to_save = {
		"player_location": save_data["player_location"],
		"player_health": save_data["player_health"],
		"current_level": save_data["current_level"],
		"level_state":  save_data["level_state"],
		"coin_collected": save_data["coin_collected"],
		"current_checkpoint": save_data["current_checkpoint"]
	}
	
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	
	file.store_string(JSON.stringify(data_to_save))
	file.close()


func is_data_exist() -> bool:
	if save_data["player_location"]:
		return true
	
	return false


func _load_weapon_collection(saved_data: Dictionary) -> void:
	save_data.weapon_collection.clear()
	
	for weapon_path in saved_data.get("weapon_collection", []):
		var weapon: Weapon = load(weapon_path)
		
		if(weapon):
			save_data.weapon_collection.append(weapon)
