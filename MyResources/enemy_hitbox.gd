class_name EnemyHitBox
extends Area2D

func _ready() -> void:
	area_entered.connect(_on_player_entered);

func _on_player_entered(_area: Hurtbox) -> void:
	pass
