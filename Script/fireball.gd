extends Node2D


@export var SPEED : float = 160
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var direction = 1
var stop : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true
	
	if !stop:
		position.x += direction * SPEED * delta 


func boom() -> void:
	stop = true
	anim.play("boom")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == 'boom':
		queue_free()
