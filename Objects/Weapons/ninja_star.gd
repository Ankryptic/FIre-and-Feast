class_name NinjaStar 
extends Node2D

@export var direction: int = 1
@export var speed: float = 60
@export var rotation_speed: float = 10

@onready var star: Sprite2D = $Star
@onready var blood_splash: AnimatedSprite2D = $BloodSplash

func _ready() -> void:
	star.visible = true
	blood_splash.visible = false


func _process(delta: float) -> void:
	star.rotation += rotation_speed * delta
	star.global_position.x += speed * direction * delta


func boom() -> void:
	star.visible = false
	blood_splash.visible = true
	blood_splash.play("green_blood")


func _on_blood_splash_animation_finished() -> void:
	if blood_splash.animation == "green_blood":
		print("finished")
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
