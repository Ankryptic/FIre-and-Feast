class_name ButtonBounce 
extends Button

var tween : Tween

@export var hover_scale: Vector2 = Vector2(1.1, 1.1);
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)


func _ready() -> void: 
	self.mouse_entered.connect(_on_mouse_entered);
	self.mouse_exited.connect(_on_mouse_exited);
	self.pressed.connect(_on_button_pressed);
	
	call_deferred('_init_pivot')

func _init_pivot() -> void:
	pivot_offset = size / 2.0

func _on_mouse_entered() -> void:
	print('Entered')
	tween = create_tween()
	tween.tween_property(self, 'scale', hover_scale, 0.1)

func _on_mouse_exited() -> void:
	tween = create_tween()
	tween.tween_property(self, 'scale', Vector2.ONE, 0.1)

func _on_button_pressed() -> void:
	tween = create_tween()
	tween.tween_property(self, 'scale', pressed_scale, 0.06)
	tween.tween_property(self, 'scale', hover_scale, 0.12)
