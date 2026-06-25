extends AnimatableBody2D

var tween : Tween
var up : Vector2 = Vector2(440.0, -299.5)
var down : Vector2 = Vector2(440.0, -171)

func _ready() -> void:
	move_up_down()

func move_up_down() -> void:
	tween = create_tween()
	tween.set_loops()
	
	tween.tween_property(self, "global_position", up, 5).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", down, 5).set_ease(Tween.EASE_OUT)
