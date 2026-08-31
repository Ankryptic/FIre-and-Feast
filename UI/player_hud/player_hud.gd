class_name PlayerHud
extends Control

# TODO - Update Player Health bar
# TODO - Update Coins
# TODO - Fetch Collected saved Coins
# TODO - 

@export var main_game: MainGame

@onready var player_health_bar: ProgressBar = $HealthCoinCon/HealthContainer/PlayerHealthBar
@onready var weapon_con: GridContainer = $WeaponCon
@onready var toggle_pause: Button = $PauseBtnContainer/TogglePause
@onready var label: Label = $HealthCoinCon/CoinCounter/HBoxContainer/Label

func _ready() -> void:
	visible = true;
	main_game.health_Changed.connect(update_health_bar)


func _process(_delta: float) -> void:
	pass


func update_health_bar(curr_heath: float, max_health: float) -> void:
	player_health_bar.max_value = max_health;
	player_health_bar.value = curr_heath
	
