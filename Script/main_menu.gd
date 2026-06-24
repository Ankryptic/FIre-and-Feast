class_name MainMenu
extends Control

#region menu container
@export var menu : MarginContainer
@export var settings : MarginContainer
#endregion

#region buttons
@export var resumeBtn : Button
@export var newGameBtn : Button
@export var settingsBtn : Button
@export var exitBtn : Button
#endregion 

#region Closing button
@export var close_setting: Button
#endregion

#region volume btns
@export var minVolBtn : Button
@export var muteVolBtn : Button
@export var volume_slider : HSlider
#endregion

#region music management
var music = AudioServer.get_bus_index("Music")
#endregion

#region Array of button, hover_property and pressed_property
var all_btn : Array[Button]
var hover_property : Vector2 = Vector2(1.1, 1.1)
var pressed_property : Vector2 = Vector2(0.9, 0.9)
var tween : Tween
#endregion

@export var MainScene : PackedScene = preload("uid://bkpes4wn5yval")
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	newGameBtn.pressed.connect(start_new_game);
	exitBtn.pressed.connect(exit_button_pressed);
	muteVolBtn.pressed.connect(muteBtn_pressed);
	minVolBtn.pressed.connect(minVolBtn_pressed);
	volume_slider.mouse_exited.connect(mouse_is_exited);
	volume_slider.value_changed.connect(set_volume)
	settingsBtn.pressed.connect(_open_settings)
	
	##Closing button
	close_setting.pressed.connect(_close_settings)
	
	# Array of All Buttons
	all_btn = [resumeBtn, newGameBtn, settingsBtn, exitBtn, close_setting]
	for button in all_btn:
		_disable_button_focus(button)
		button.mouse_entered.connect(_on_mouse_hover.bind(button));
		button.mouse_exited.connect(_on_mouse_unhover.bind(button));
		#button.pressed.connect(_on_button_pressed.bind(button));

func toggle_visibility(object : MarginContainer) -> void:
	if object.visible == true:
		anim_player.play('close_' + object.name)
	else:
		anim_player.play('open_' + object.name)

func start_new_game() -> void:
	get_tree().change_scene_to_packed(MainScene);
	queue_free();

func exit_button_pressed() -> void:
	get_tree().quit();

func muteBtn_pressed() -> void:
	volume_slider.value = 0.0

func minVolBtn_pressed() -> void:
	volume_slider.value = 0.5

func mouse_is_exited() -> void:
	volume_slider.release_focus()

func _open_settings() -> void:
	toggle_visibility(settings)

func _close_settings() -> void:
	toggle_visibility(settings)

func set_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(music, linear_to_db(value))

func _on_mouse_hover(button : Button) -> void:
	_init_pivot_point(button)
	tween = create_tween()
	tween.tween_property(button, 'scale', hover_property, 0.15)

func _on_mouse_unhover(button : Button) -> void:
	_init_pivot_point(button)
	tween = create_tween()
	tween.tween_property(button, 'scale', Vector2.ONE, 0.3)

#func _on_button_pressed(button:Button) -> void:
	#print(button.name)
	#pass

func _init_pivot_point(button: Button) -> void:
	button.pivot_offset = button.size / 2.0

func _disable_button_focus(button: Button) -> void:
	var empty_style := StyleBoxEmpty.new()
	button.add_theme_stylebox_override('focus', empty_style)
