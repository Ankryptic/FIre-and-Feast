class_name ExitGate
extends Area2D

# Exit Gate for Player to Next level

# TODO: Move Player to the exit portal using AnimationPlayer or tween

const PORTAL_UID: String = "uid://c34yyw0lmmfud"

@export var gate_position: Marker2D
@onready var coll_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	body_entered.connect(open_portal_for_exit)


func open_portal_for_exit(body: Player) -> void:
	if not body.is_in_group("player_group"):
		return

	body.in_cutscene = true;
	body.velocity.x = 0;
	
	call_deferred("spawn_portal");


func spawn_portal() -> void:
	var instance = ResourceLoader.load(PORTAL_UID, "PackedScene") as PackedScene
	var portal_scene = instance.instantiate()
	
	var object_container = get_parent().get_node("ObjectContainer");
	object_container.add_child(portal_scene);

	
	portal_scene.global_position = gate_position.global_position
	portal_scene.auto_dissapp = false
	portal_scene.appear()
	coll_shape.disabled = true;
