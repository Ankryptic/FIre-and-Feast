extends Button

@export var weapon: Weapon:
	set(weapon_to_set):
		weapon = weapon_to_set
		icon = weapon_to_set.texture
