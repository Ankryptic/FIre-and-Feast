class_name NinjaStar 
extends Node2D

@export var direction: int = 1
@export var speed: float = 120
@export var damage: int = 5
@export var rotation_speed: float = 10

var stop: bool = false

@onready var star: Sprite2D = $Star
@onready var blood_splash: AnimatedSprite2D = $BloodSplash
@onready var visible_on_screen: VisibleOnScreenEnabler2D = $Star/VisibleOnScreenEnabler2D

func _ready() -> void:
	star.visible = true
	blood_splash.visible = false
	visible_on_screen.visible = true


func _process(delta: float) -> void:
	if stop:
		return
	
	
	star.rotation += rotation_speed * delta
	star.global_position.x += speed * direction * delta


func play_animation() -> void:
	if direction > 0:
		blood_splash.flip_h = false
	elif direction < 0:
		blood_splash.flip_h = true
	
	blood_splash.global_position = star.global_position
	blood_splash.visible = true
	blood_splash.play("green_blood")

## Animate when collides with Enemy
func boom() -> void:
	visible_on_screen.free()
	stop = true
	star.visible = false
	play_animation()

## Animate when collide with wall or static objects
func collide_to_wall() -> void:
	stop = true
	queue_free()


func _on_blood_splash_animation_finished() -> void:
	if blood_splash.animation == "green_blood":
		print("Booming")
		queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
