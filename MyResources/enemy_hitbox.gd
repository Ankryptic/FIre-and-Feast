class_name EnemyHitBox
extends Area2D

func _ready() -> void:
	area_entered.connect(_on_player_hurtbox_entered);

func _on_player_hurtbox_entered(_area: Area2D) -> void:
	#print("Area Entered -> ", _area.owner.name)
	pass
