class_name PlayerHud
extends Control

# TODO - Collect Weapon
# TODO - 

@export var main_game: MainGame

var active_weapon: Button:
	set(value):
		active_weapon = value
		active_weapon.button_pressed = true

@onready var player_health_bar: ProgressBar = $HealthCoinCon/HealthContainer/PlayerHealthBar
@onready var weapon_con: GridContainer = $WeaponCon
@onready var toggle_pause: Button = $PauseBtnContainer/TogglePause
@onready var label: Label = $HealthCoinCon/CoinCounter/HBoxContainer/Label
@onready var weapon_slot_1: Button = $WeaponCon/WeaponSlot1
@onready var weapon_slot_2: Button = $WeaponCon/WeaponSlot2

func _ready() -> void:
	visible = true;
	_init_coin_counter()
	_init_health_bar()
	_init_weapon()
	main_game.health_Changed.connect(update_health_bar)
	main_game.coin_changed.connect(update_coin_collection)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap"):
		switch_weapon()


func _init_coin_counter() -> void:
	label.text = str(0)


func _init_health_bar() -> void:
	if SaveLoad.is_data_exist():
		var max_value = SaveLoad.save_data.player_health.get("max_health", 100)
		var curr_value = SaveLoad.save_data.player_health.get('current_health', 100)
		
		player_health_bar.max_value = max_value
		player_health_bar.value = curr_value
	
	else:
		player_health_bar.max_value = 100.0
		player_health_bar.value = 100.0


func _init_weapon() -> void:
	if weapon_slot_1.can_equip:
		active_weapon = weapon_slot_1
	
	return


func update_health_bar(curr_heath: float, max_health: float) -> void:
	player_health_bar.max_value = max_health;
	player_health_bar.value = curr_heath


func update_coin_collection(amount: int) -> void:
	label.text = str(amount)


func switch_weapon() -> void:
	for weapon in weapon_con.get_children():
		if active_weapon == weapon:
			continue
		if weapon.can_equip:
			active_weapon.button_pressed = false
			active_weapon = weapon
			return
