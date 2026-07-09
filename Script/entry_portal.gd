extends Node2D

@onready var portal: AnimatedSprite2D = $portal
@onready var particles: AnimatedSprite2D = $particles

func _ready() -> void:
	appear()



func appear() -> void:
	portal.play("default")
	await portal.animation_finished
	
	particles.play("default")
	var tween = create_tween()
	tween.tween_property(particles, "modulate:a", 1.0, 0.5)
	
	await get_tree().create_timer(5).timeout
	dissappear()


func dissappear() -> void:
	var tween = create_tween()
	tween.tween_property(particles, "modulate:a", 0.0, 0.5)
	
	portal.play_backwards("default")
	await portal.animation_finished
	queue_free()
