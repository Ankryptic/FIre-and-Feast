class_name SceneContainer
extends Node2D

## Cut Scene Container

signal cut_scene_started

#region @onready variables
@onready var cut_scene_manager: Node2D = %CutSceneManager
#endregion

func start_cut_scene() -> void:
	#player.in_cutscene = true
	cut_scene_started.emit()
	cut_scene_manager._action()
