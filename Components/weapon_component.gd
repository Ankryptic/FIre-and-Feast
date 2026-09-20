class_name WeaponComponent
extends Node

#TODO - Update weapon in HUD
#TODO - Fuck Shreeraj

var main_game: MainGame

signal weapon_collected(weapons: Array[Weapon])

var weapons: Array[Weapon] = []

var weapon_on_hand: PackedScene

func _ready() -> void:
	main_game = SceneManager.main_game
	main_game.active_weapon_changed.connect(_set_Active_weapon)
	
	# Fetch already collected weapon
	_init_weapon()
	_init_weapon_on_hand()


func _emit_weapon_collected() -> void:
	weapon_collected.emit(weapons)

func _set_Active_weapon(res: Weapon) -> void:
	weapon_on_hand = ResourceLoader.load(res.uid, "PackedScene") as PackedScene

func _init_weapon() -> void:
	if not SaveLoad.is_data_exist():
		return
	
	weapons.clear()
	
	for weapon in SaveLoad.save_data.weapon_collection:
		weapons.append(weapon)
	
	_emit_weapon_collected()


func _init_weapon_on_hand() -> void:
	if weapons[1]:
		_set_Active_weapon(weapons[1])
