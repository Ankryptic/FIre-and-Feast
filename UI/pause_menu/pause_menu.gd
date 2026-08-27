class_name PauseMenu
extends Control

@onready var continue_btn: Button = $VBoxContainer/ContinueBtn
@onready var settings_btn: Button = $VBoxContainer/SettingsBtn
@onready var help_btn: Button = $VBoxContainer/HelpBtn
@onready var quit_btn: Button = $VBoxContainer/QuitBtn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var all_btns = [continue_btn, settings_btn, help_btn, quit_btn]
	
	for button in all_btns:
		button.mouse_entered.connect(_on_mouse_hover.bind(button))
		button.mouse_exited.connect(_on_mouse_unhover.bind(button))


func _on_mouse_hover(btn: Button) -> void:
	print(btn.name)
	pass
	

func _on_mouse_unhover(btn: Button) -> void:
	print("Unhover, " ,btn.name)
	pass
