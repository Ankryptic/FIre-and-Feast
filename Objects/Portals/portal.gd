extends Node2D

## Portal Script

var entry_time: int
var isNormal := true
var auto_dissapp := true
var dissapp_time: int = 1

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
	
	## Controls the static body
	if not isNormal:
		await get_tree().create_timer(entry_time).timeout
		static_body.queue_free()
	
	if auto_dissapp:
		await get_tree().create_timer(dissapp_time).timeout
		dissappear()


func dissappear() -> void:
	var tween = create_tween()
	tween.tween_property(particles, "modulate:a", 0.0, 0.5)
	
	portal.play_backwards("default")
	await portal.animation_finished
	queue_free()
