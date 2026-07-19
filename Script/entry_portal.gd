extends Node2D

## This portal is for Entry

@export var entry_time: int

@onready var portal: AnimatedSprite2D = $portal
@onready var particles: AnimatedSprite2D = $particles
@onready var static_body: StaticBody2D = $StaticBody2D

func _ready() -> void:
	visible = false

func appear() -> void:
	visible = true
	portal.play("default")
	await portal.animation_finished
	
	particles.play("default")
	var tween = create_tween()
	tween.tween_property(particles, "modulate:a", 1.0, 0.5)
	await get_tree().create_timer(entry_time).timeout
	static_body.queue_free()
	
	await get_tree().create_timer(3).timeout
	dissappear()


func dissappear() -> void:
	var tween = create_tween()
	tween.tween_property(particles, "modulate:a", 0.0, 0.5)
	
	portal.play_backwards("default")
	await portal.animation_finished
	queue_free()
