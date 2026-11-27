extends Node2D

## Handle Shooting for the Purple Slime

var ice_Shard_uid: String = "uid://eu458mhp0jav";


@onready var right_shooter: Marker2D = $RightShooter
@onready var left_shooter: Marker2D = $LeftShooter


var facing_towards: int  # Slime facing direction left or right
var active_shooter: Marker2D
var ice_shard_scene: PackedScene 


func _ready() -> void:
	facing_towards = owner.direction
	load_ice_shard_scene.call_deferred();
	owner.connect("player_detected", shoot)


func load_ice_shard_scene() -> void:
	ice_shard_scene = ResourceLoader.load(ice_Shard_uid, "PackedScene") as PackedScene;


func update_shooter() -> void:
	facing_towards = owner.direction;
	
	if sign(facing_towards) == 1:
		active_shooter = right_shooter;
	if sign(facing_towards) == -1:
		active_shooter = left_shooter;

func shoot() -> void:
	if ice_shard_scene == null:
		printerr("Ice Shard Scene not found!");
		return;
	
	update_shooter();
	
	if active_shooter == null:
		printerr("Active Shooter not found!");
		return;
	
	print(active_shooter.name)
	
	var ice_shard = ice_shard_scene.instantiate();
	add_child.call_deferred(ice_shard);
	ice_shard.set_deferred("global_position", active_shooter.global_position);
