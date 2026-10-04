class_name CollectionComponent
extends Node

## This Component is used to place Collectible in Marker2D Position

const collectible_weapon = {
	0: {
		'name': 'ninja star',
		'uid': "uid://6vtmoml6tixh"
		},
	1: {
		'name': 'fireball',
		'uid': "uid://dhv7w15kg645a" 
		}
}

@onready var ninja_marker: Marker2D = $NinjaMarker
@onready var fireball_marker: Marker2D = $FireballMarker


func _ready() -> void:
	call_deferred("_load_weapon_on_level")


func check_in_saved_collection(weapon_name: String) -> bool:
	for weapon: Weapon in SaveLoad.save_data.weapon_collection:
		if weapon.name == weapon_name:
			return true;
		
	return false;


func _load_weapon_on_level() -> void:
	
	for idx in collectible_weapon:
		# While loading check that weapon is already picked or not
		var weapon_name: String = collectible_weapon[idx]['name']
		
		var collected = check_in_saved_collection(weapon_name)
		if collected:
			continue;
		
		var temp_scene: PackedScene = ResourceLoader.load(collectible_weapon[idx]['uid'], \
		"PackedScene") as PackedScene
		var weapon: Node2D = temp_scene.instantiate()
		weapon.global_position = get_child(idx).global_position
		get_child(idx).queue_free()
		add_child(weapon)
	
