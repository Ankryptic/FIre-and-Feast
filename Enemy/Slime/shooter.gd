extends Node2D

## Handle Shooting for the Purple Slime

var ice_Shard_uid: String = "uid://eu458mhp0jav";

@onready var right_shooter: Marker2D = $RightShooter
@onready var left_shooter: Marker2D = $LeftShooter

var facing_towards: int  # Slime facing direction left or right
var ice_shard_scene: PackedScene

func _ready() -> void:
	facing_towards = owner.direction
	load_ice_shard_scene.call_deferred();


func _process(_delta: float) -> void:
	print("Left: ", left_shooter.global_position)
	print("Owner: ", owner.global_position)


func load_ice_shard_scene() -> void:
	ice_shard_scene = ResourceLoader.load(ice_Shard_uid, "PackedScene") as PackedScene;
	var ice_shard = ice_shard_scene.instantiate();
	ice_shard.stop = true
	ice_shard.global_position = right_shooter.global_position
	add_child(ice_shard)
