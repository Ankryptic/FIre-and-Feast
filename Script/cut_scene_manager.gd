class_name CutSceneManager
extends Node2D

## This node manages all the cutscene in this level


#region @onready variables
@onready var player: Player = $"../Player"
@onready var scene_manager: Node2D = $SceneManager
#endregion

func _ready() -> void:
	player.in_cutscene = true
	scene_manager._action()
