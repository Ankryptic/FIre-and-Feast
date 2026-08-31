class_name PlayerHud
extends Control

# TODO - Fetch Collected saved Coins
# TODO - 

@export var main_game: MainGame

@onready var player_health_bar: ProgressBar = $HealthCoinCon/HealthContainer/PlayerHealthBar
@onready var weapon_con: GridContainer = $WeaponCon
@onready var toggle_pause: Button = $PauseBtnContainer/TogglePause
@onready var label: Label = $HealthCoinCon/CoinCounter/HBoxContainer/Label

func _ready() -> void:
	visible = true;
	_init_coin_counter()
	_init_health_bar()
	main_game.health_Changed.connect(update_health_bar)
	main_game.coin_changed.connect(update_coin_collection)


func _process(_delta: float) -> void:
	pass


func _init_coin_counter() -> void:
	label.text = str(0)

func _init_health_bar() -> void:
	if SaveLoad.is_data_exist():
		print(SaveLoad.save_data.player_health)


func update_health_bar(curr_heath: float, max_health: float) -> void:
	player_health_bar.max_value = max_health;
	player_health_bar.value = curr_heath


func update_coin_collection(amount: int) -> void:
	label.text = str(amount)
