class_name Level1
extends Node2D

# Level 1 Script

@export var coin_container: Node2D
@onready var cut_scene_container: SceneContainer = $CutSceneContainer
@onready var player_sp: Marker2D = $PlayerSP
@onready var cut_scene_manager: Node2D = %CutSceneManager

func _ready() -> void:
	cut_scene_container.cut_scene_started.connect(cut_scene_started)
	cut_scene_container.start_cut_scene()


## Set the Player Reference in the Current Level
func _set_player(player_ref: Player) -> void:
	player_ref.global_position = player_sp.global_position


func cut_scene_started() -> void:
	_set_player(SceneManager.player)
	coin_container.visible = false


func cut_scene_ended() -> void:
	coin_container.visible = true
