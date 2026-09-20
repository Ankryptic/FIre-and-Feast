class_name PlayerHud
extends Control

# TODO - Pass Active Weapon to the Player
# TODO - 

signal active_weapon_changed(res: Weapon)

@export var main_game: MainGame

var weapon_collection: Array[Weapon] = []
var weapon_idx: int
var active_weapon: Button:
	set(value):
		if active_weapon != null:
			active_weapon.button_pressed = false
	
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
	#_init_weapon()
	main_game.health_Changed.connect(update_health_bar)
	main_game.coin_changed.connect(update_coin_collection)
	main_game.update_weapon_collection.connect(add_weapon_in_collection);
	


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


#func _init_weapon() -> void:
	#if weapon_slot_1.can_equip:
		#active_weapon = weapon_slot_1
	#
	#return


func update_health_bar(curr_heath: float, max_health: float) -> void:
	player_health_bar.max_value = max_health;
	player_health_bar.value = curr_heath


func update_coin_collection(amount: int) -> void:
	label.text = str(amount)


func add_weapon_in_collection(weapons: Array[Weapon]) -> void:
	weapon_collection = weapons
	update_weapons_in_ui()


func update_weapons_in_ui() -> void:
	for idx in weapon_collection.size():
		var slot = weapon_con.get_child(idx)
		var icon = weapon_collection[idx].texture
		slot.icon = icon
		active_weapon = slot
		
		# Update weapon Index for Switching weapon
		weapon_idx = idx


func switch_weapon() -> void:
	if weapon_collection.size() <= 1:
		return;
	
	if weapon_idx == (weapon_con.get_children().size() - 1):
		weapon_idx = 0
	else:
		weapon_idx += 1 
	
	active_weapon = weapon_con.get_child(weapon_idx)
	active_weapon_changed.emit(weapon_collection[weapon_idx])
	return
