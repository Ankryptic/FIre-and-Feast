class_name WeaponComponent
extends Node

#TODO - Update weapon in HUD
#TODO - Update Weapon Switch mechanism
#TODO - Fuck Shreeraj

signal weapon_collected(weapons: Array[Weapon])

var weapons: Array[Weapon] = []

var weapon_on_hand: String
var can_switch: bool


func _emit_weapon_collected() -> void:
	weapon_collected.emit(weapons)
