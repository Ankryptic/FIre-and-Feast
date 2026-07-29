class_name Level1
extends Node2D

# Level 1 Script

@export var coin_container: Node2D
@export var cut_scene_manager: CutSceneManager


func _ready() -> void:
	cut_scene_manager.cut_scene_started.connect(cut_scene_started)
	cut_scene_manager.start_cut_scene()


func cut_scene_started() -> void:
	coin_container.visible = false


func cut_scene_ended() -> void:
	coin_container.visible = true
