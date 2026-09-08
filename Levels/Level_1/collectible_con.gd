class_name CollectionComponent
extends Node

## This Component is used to place Collectible in Marker2D Position

const collectible_weapon = {
	0: "uid://6vtmoml6tixh", # Ninja collectible
	1: "uid://dhv7w15kg645a",  # Fireball Collectible
}

@onready var ninja_marker: Marker2D = $NinjaMarker
@onready var fireball_marker: Marker2D = $FireballMarker


func _ready() -> void:
	call_deferred("_load_weapon_on_level")


func _load_weapon_on_level() -> void:
	
	for idx in collectible_weapon:
		var temp_scene: PackedScene = ResourceLoader.load(collectible_weapon[idx], \
		"PackedScene") as PackedScene
		var weapon: Node2D = temp_scene.instantiate()
		weapon.global_position = get_child(idx).global_position
		get_child(idx).queue_free()
		add_child(weapon)
	
