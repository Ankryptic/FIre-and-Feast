class_name Hurtbox
extends Area2D

var hit_direction : int = 1

func _ready() -> void:
	area_entered.connect(on_hitbox_entered)

func update_hit_direction(dir: int) -> void:
	hit_direction = dir

func on_hitbox_entered(_area: Hitbox) -> void:
	#print('Got Hit')
	
	owner.get_damage(hit_direction)
