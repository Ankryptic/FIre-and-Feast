class_name CutSceneManager
extends Node2D

## This node manages all the cutscene in this level

signal cutscene_ended

#region @onready variables
@onready var player: Player = $"../Player"
@onready var level_1_chapter_1: Node2D = $Level1Chapter1
#endregion

func _ready() -> void:
	player.in_cutscene = true
	level_1_chapter_1._action()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
