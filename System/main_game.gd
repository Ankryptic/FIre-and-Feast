class_name MainGame
extends Node

# main game script

var current_ui : Control

var next_level: String = "uid://bkpes4wn5yval"
var current_level : Node2D

@onready var level_root: Node2D = $World/LevelRoot

func _ready() -> void:
	load_level(next_level)


func load_level(new_level: String) -> void:
	var new_scene: PackedScene = ResourceLoader.load(new_level, "PackedScene") as PackedScene
	
	if (new_scene != null):
		var level := new_scene.instantiate();
		current_level = level
		
		level_root.add_child(current_level)
	pass

func update_ui(new_scene : PackedScene) -> void:
	if current_ui != null:
		current_ui.queue_free();
	
	var new = new_scene.instantiate()
	current_ui = new
