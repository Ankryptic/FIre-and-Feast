class_name CollectionComponent
extends Node

const collectible_weapon = {
	"ninja": "uid://6vtmoml6tixh",
	"fireball": "uid://dhv7w15kg645a",
}

@onready var ninja_marker: Marker2D = $NinjaMarker
@onready var fireball_marker: Marker2D = $FireballMarker


func _ready() -> void:
	call_deferred("_load_weapon_on_level")


func _load_weapon_on_level() -> void:
	pass
