class_name GameControl
extends Node

@onready var level_manager: Node2D = $LevelManager
@onready var ui: CanvasLayer = $UI

var current_level : Node2D
@export var current_ui : Control

func _ready() -> void:
	GlobalManager.GameControl = self
	var new_scene : PackedScene = load("uid://bwev0exxtw037")
	update_ui(new_scene)


func update_ui(new_scene : PackedScene) -> void:
	if current_ui != null:
		current_ui.queue_free();
	
	var new = new_scene.instantiate()
	get_tree().change_scene_to_packed(new)
	add_child(new)
	
