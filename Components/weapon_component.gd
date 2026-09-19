class_name WeaponComponent
extends Node

#TODO - Update weapon in HUD
#TODO - Update Weapon Switch mechanism
#TODO - Fuck Shreeraj

var main_game: MainGame

signal weapon_collected(weapons: Array[Weapon])

var weapons: Array[Weapon] = []

var weapon_on_hand: PackedScene
var can_switch: bool

func _ready() -> void:
	main_game = SceneManager.main_game
	main_game.active_weapon_changed.connect(_set_Active_weapon)
	
	# Fetch already collected weapon
	_init_weapon()


func _emit_weapon_collected() -> void:
	weapon_collected.emit(weapons)

func _set_Active_weapon(uid: String) -> void:
	weapon_on_hand = load(uid)

func _init_weapon() -> void:
	if not SaveLoad.is_data_exist():
		return
	
	weapons.clear()
	
	for weapon in SaveLoad.save_data.weapon_collection:
		weapons.append(weapon)
	
	_emit_weapon_collected()
