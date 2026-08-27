class_name PlayerHud
extends Control

@onready var player_health_bar: ProgressBar = $HealthCoinCon/HealthContainer/PlayerHealthBar
@onready var weapon_con: GridContainer = $WeaponCon
@onready var toggle_pause: Button = $PauseBtnContainer/TogglePause
@onready var label: Label = $HealthCoinCon/CoinCounter/HBoxContainer/Label

func _ready() -> void:
	visible = true;


func _process(_delta: float) -> void:
	pass
