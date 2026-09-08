class_name Collectible
extends Area2D

@export var item: Weapon

func _ready() -> void:
	if !item:
		printerr("Item is Missing")
		return
	
	body_entered.connect(_on_player_enters);

func _on_player_enters(body: Player) -> void:
	var weapon_con = body.get_node("WeaponComponent")
	weapon_con.weapons.push_back(item)
	weapon_con._emit_weapon_collected()
	queue_free()
