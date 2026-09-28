class_name ExitGate
extends Area2D

# Exit Gate for Player to Next level

const PORTAL_UID: String = "uid://c34yyw0lmmfud"

@export var gate_position: Marker2D

func _ready() -> void:
	area_entered.connect(open_portal_for_exit)


func open_portal_for_exit(area: Player) -> void:
	if not area.is_in_group("player_group"):
		return
	
	var instance = ResourceLoader.load(PORTAL_UID, "PackedScene") as PackedScene
	var portal_scene = instance.instantiate()
	portal_scene.global_position = gate_position.global_position
	
	var parent = get_parent()
	parent.get_node("ObjectContainer").add_child(portal_scene)
