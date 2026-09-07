class_name WeaponComponent
extends Node

var weapons: Array[Weapon] = []

var weapon_on_hand: String
var can_switch: bool


func _print_weapon() -> void:
	for weapon in weapons:
		print(weapon)
