class_name SceneContainer
extends Node2D

## Cut Scene Container

signal cut_scene_started

@export var level_id: int

var player: Player

@onready var cut_scene_manager: Node2D = %CutSceneManager


func _ready() -> void:
	cut_scene_manager.cut_scene_finished.connect(cut_scene_finish)


func start_cut_scene() -> void:
	player = SceneManager.player
	player.in_cutscene = true
	cut_scene_started.emit()
	cut_scene_manager._action()


func cut_scene_finish() -> void:
	player.in_cutscene = false
	
	# Save level state and player location after cutscene finished
	SaveLoad.save_data.player_location = {
		"x": player.global_position.x,
		"y": player.global_position.y
	}
	SaveLoad.save_data.current_level = level_id
	SaveLoad.save_data.level_state = {
		str(level_id): {"cutscene_finished": true}
	}
	SaveLoad._save_game()
