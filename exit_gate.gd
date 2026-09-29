class_name ExitGate
extends Area2D

# Exit Gate for Player to Next level

const PORTAL_UID: String = "uid://c34yyw0lmmfud"

@export var gate_position: Marker2D

func _ready() -> void:
	body_entered.connect(open_portal_for_exit)


func open_portal_for_exit(body: Player) -> void:
	if not body.is_in_group("player_group"):
		return
	
	call_deferred("spawn_portal");


func spawn_portal() -> void:
	var instance = ResourceLoader.load(PORTAL_UID, "PackedScene") as PackedScene
	var portal_scene = instance.instantiate()
	
	var object_container = get_parent().get_node("ObjectContainer");
	object_container.add_child(portal_scene);
	
	portal_scene.global_position = gate_position.global_position
	
	portal_scene.appear()
