class_name PauseMenu
extends Control

# TODO - Add Setting Menu
# TODO - Add Help Menu
# TODO - 


@export var hover_property: Vector2 = Vector2(1.1, 1.1)
@export var continue_btn: Button 
@export var settings_btn: Button 
@export var help_btn: Button
@export var quit_btn: Button 

var main_menu_path: String = "uid://bwev0exxtw037"


func _ready() -> void:
	continue_btn.pressed.connect(_on_continue_button_pressed)
	settings_btn.pressed.connect(_on_setting_button_pressed)
	help_btn.pressed.connect(_on_help_button_pressed)
	quit_btn.pressed.connect(_on_Quit_button_pressed)
	
	var all_btns = [continue_btn, settings_btn, help_btn, quit_btn]
	
	for button in all_btns:
		button.mouse_entered.connect(_on_mouse_hover.bind(button))
		button.mouse_exited.connect(_on_mouse_unhover.bind(button))


func _on_continue_button_pressed() -> void:
	get_parent().visible = false
	get_tree().paused = false


func _on_setting_button_pressed() -> void:
	pass

func _on_help_button_pressed() -> void:
	pass


## Change MainGame to MainMenu
func _on_Quit_button_pressed() -> void:
	SceneManager.load_scene(main_menu_path)


#region Hover Effect
func _on_mouse_hover(btn: Button) -> void:
	_init_pivot_point(btn)
	var tween = create_tween()
	tween.tween_property(btn, "scale", hover_property, 0.12)


func _on_mouse_unhover(btn: Button) -> void:
	_init_pivot_point(btn)
	var tween = create_tween()
	tween.tween_property(btn, "scale", Vector2.ONE, 0.12)


func _init_pivot_point(button: Button) -> void:
	button.pivot_offset = button.size / 2

#endregion
