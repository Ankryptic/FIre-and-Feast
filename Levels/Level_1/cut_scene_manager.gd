class_name CutSceneManager
extends Node2D

## This node manages all the cutscene in this level

signal cut_scene_started

var player: Player

#region @onready variables
@onready var scene_manager: Node2D = $SceneManager
#endregion

func start_cut_scene() -> void:
	#player.in_cutscene = true
	cut_scene_started.emit()
	scene_manager._action()
