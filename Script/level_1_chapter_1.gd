extends Node2D

## Level 1 Chapter 1 CutScene

@export var cam_speed := 10

@onready var entry_portal: Node2D = $EntryPortal
@onready var cut_scene_manager: CutSceneManager = $".."
@onready var cam: Camera2D = $Path2D/PathFollow2D/Camera2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D

func _physics_process(delta: float) -> void:
	path_follow.progress += cam_speed * delta


func _action() -> void:
	set_physics_process(false)
	player_entry()
	camera_movement()

func player_entry() -> void:
	entry_portal.appear()

func camera_movement() -> void:
	set_physics_process(true)

func _cutscene_ended() -> void:
	cut_scene_manager.cutscene_ended.emit()
