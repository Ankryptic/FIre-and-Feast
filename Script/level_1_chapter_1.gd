extends Node2D

## Level 1 Chapter 1 CutScene

@onready var entry_portal: Node2D = $EntryPortal
@onready var cut_scene_manager: CutSceneManager = $".."

func _action() -> void:
	player_entry()

func player_entry() -> void:
	entry_portal.appear()

func _cutscene_ended() -> void:
	cut_scene_manager.cutscene_ended.emit()
