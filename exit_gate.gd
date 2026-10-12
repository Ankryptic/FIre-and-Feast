class_name ExitGate
extends Area2D

# Exit Gate for Player to Next level

# TODO: Move Player to the exit portal using AnimationPlayer or tween

const PORTAL_UID: String = "uid://c34yyw0lmmfud"

var main_game: MainGame
var global_animation_player: AnimationPlayer
var player: Player

@export var gate_position: Marker2D
@onready var coll_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	body_entered.connect(open_portal_for_exit)
	main_game = SceneManager.main_game
	global_animation_player = main_game.get_node("GlobalAnimationPlayer")


func open_portal_for_exit(body: Player) -> void:
	if not body.is_in_group("player_group"):
		return

	body.in_cutscene = true;
	body.velocity.x = 0;
	
	# Block the cutscene_movement_control method in the player to prevent 
	# overriding the aniamtion
	body.pause_movement = true
	
	call_deferred("spawn_portal", body);


func spawn_portal(body: Player) -> void:
	var instance = ResourceLoader.load(PORTAL_UID, "PackedScene") as PackedScene
	var portal_scene = instance.instantiate()
	
	var object_container = get_parent().get_node("ObjectContainer");
	object_container.add_child(portal_scene);

	
	portal_scene.global_position = gate_position.global_position
	portal_scene.auto_dissapp = false
	portal_scene.appear()
	coll_shape.disabled = true;
	
	if not global_animation_player:
		printerr("GlobalAnimationPlayer not found");
		return;
	
	if not main_game:
		printerr("MainGame Node not found");
		return;
	
	var positions: Dictionary = {
		'portal': gate_position.global_position
	}
	
	main_game.setup_animation_player(positions)
	
	if not is_instance_valid(body):
		printerr('Player not found')
	
	global_animation_player.play("exit_walk")
	body.change_state(body.States.RUN)
	
	while true:
		var animation_finished: StringName = await global_animation_player.animation_finished
		
		if animation_finished == &"exit_walk":
			body.change_state(body.States.IDLE)
			break;
