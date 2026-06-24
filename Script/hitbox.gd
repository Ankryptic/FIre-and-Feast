class_name Hitbox 
extends Area2D

func _ready() -> void:
	area_entered.connect(on_hurtbox_enter)
	body_entered.connect(on_body_entered)
	

func hit() -> void:
	#$CollisionShape2D.disabled = true
	owner.boom()


func on_hurtbox_enter(area : Hurtbox) -> void:
	#print('hurtBox -> ' ,area.name)
	area.update_hit_direction(owner.direction)
	hit()

func on_body_entered(_body : Node2D) -> void:
	#print('Body Entered -> ', body.name)
	hit()
