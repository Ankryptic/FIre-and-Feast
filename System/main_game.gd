class_name MainGame
extends Node

# main game script

var current_ui : Control

var player_path: String = "uid://dsd45eb3073we"
var next_level: String = "uid://bkpes4wn5yval"
var current_level : Node2D
var player: Player

@onready var level_root: Node2D = $World/LevelRoot
@onready var entity_root: Node2D = $World/EntityRoot

func _ready() -> void:
	_init_player();
	
	load_level(next_level)


## Load new Level
func load_level(new_level: String) -> void:
	# Make Sure to Load Scene When its Idle
	_deferred_load_level.call_deferred(new_level)


## Loads the Player 
func _init_player() -> void:
	var player_scene = ResourceLoader.load(player_path, "PackedScene") as PackedScene
	if player_scene == null:
		print("Unable to load Player Scene, ", player_path)
		return
	
	player = player_scene.instantiate()
	
	if player == null:
		print("Unable to Instantiate")
		return 
	
	#entity_root.add_child(player)


## Load Level When System is Idle
func _deferred_load_level(new_level: String) -> void:
	print(new_level)
	if current_level != null:
		current_level.queue_free()
		current_level = null
	
	await get_tree().process_frame
	
	var level = ResourceLoader.load(new_level, "PackedScene") as PackedScene
	
	if level == null:
		print("Level Not Found: %d" % new_level)
	
	current_level = level.instantiate()
	level_root.add_child(current_level)
	
	await get_tree().process_frame


## Update the UI like Pause Menu, HUD
func update_ui(new_scene : PackedScene) -> void:
	if current_ui != null:
		current_ui.queue_free();
	
	var new = new_scene.instantiate()
	current_ui = new
