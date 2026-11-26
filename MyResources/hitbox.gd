class_name Hitbox 
extends Area2D

func _ready() -> void:
	area_entered.connect(on_hurtbox_enter)
	body_entered.connect(on_body_entered)
	
 

func on_hurtbox_enter(area : Area2D) -> void:
	print('hurtBox -> ' ,area.name)
	
	if area.has_method("update_hit_direction"):
		area.update_hit_direction(owner.direction)
	
	owner.boom()
	

func on_body_entered(_body : Node2D) -> void:
	#print('Body Entered -> ', body.name)
	owner.collide_to_wall()
