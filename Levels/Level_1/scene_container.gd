class_name SceneContainer
extends Node2D

## Cut Scene Container

signal cut_scene_started

var player: Player

#region @onready variables
@onready var cut_scene_manager: Node2D = %CutSceneManager
#endregion


func _ready() -> void:
	cut_scene_manager.cut_scene_finished.connect(cut_scene_finish)


func start_cut_scene() -> void:
	player = SceneManager.player
	player.in_cutscene = true
	cut_scene_started.emit()
	cut_scene_manager._action()


func cut_scene_finish() -> void:
	player.in_cutscene = false
	pass
