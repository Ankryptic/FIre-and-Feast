extends Node2D

# Level 1 Cut Scene Manager

signal cut_scene_finished

enum Scenes{
	SCENE_1,
	SCENE_2,
	SCENE_3,
	SCENE_4,
	SCENE_5,
	SCENE_6,
	SCENE_7,
	SCENE_8,
	SCENE_9,
}


@export var girl: CharacterBody2D
@export var cam_speed := 10

#region normal variables
var player: Player
var main_boss: MainBoss
var main_boss_path: String = "uid://b005jf7hbt1k5"
var portal_path: String = "uid://c34yyw0lmmfud"
var curr_scene: Scenes = Scenes.SCENE_1
var target_distance: float
var portal: Node2D
var scene_running: bool = false
#endregion

#region onready variables
@onready var cut_scene_container: SceneContainer = $".."
@onready var cam: Camera2D = $Path2D/PathFollow2D/Camera2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
@onready var portal_sp: Marker2D = $MarkerContainer/PortalSP
@onready var portal_sp_2: Marker2D = $MarkerContainer/PortalSP2
@onready var portal_sp_3: Marker2D = $MarkerContainer/PortalSP3
@onready var portal_sp_4: Marker2D = $MarkerContainer/PortalSP4
@onready var main_boss_sp: Marker2D = $"../../MainBossSP"
@onready var object_container: Node = $"../../ObjectContainer"
@onready var entity: Node = $"../../Entity"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
#endregion


func _ready() -> void:
	player = SceneManager.player


func _physics_process(delta: float) -> void:
	if scene_running:
		return
	
	manage_current_scene(delta)


func _action() -> void:
	start_scene(Scenes.SCENE_1)


## Manage the Current Scene 
func manage_current_scene(delta: float) -> void:
	match curr_scene:
		Scenes.SCENE_1:
			scene_1(delta)
		Scenes.SCENE_2:
			scene_2(delta)
		Scenes.SCENE_3:
			scene_3()
		Scenes.SCENE_4:
			scene_4()
		Scenes.SCENE_5:
			scene_5()
		Scenes.SCENE_6:
			scene_6()
		Scenes.SCENE_7:
			scene_7()
		Scenes.SCENE_8:
			scene_8()
		Scenes.SCENE_9:
			scene_9()


## fade in animation
func fade_in(obj: Node2D) -> bool:
	var tween = create_tween()
	tween.tween_property(obj, "modulate:a", 1, 0.2)
	await tween.finished
	return true


## fade out animation
func fade_out(obj: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property(obj, "modulate:a", 0, 0.2)


## set the desired location target and stores value in target_distance
func set_target(actor: CharacterBody2D, offset: float) -> void:
	target_distance = actor.global_position.x + offset


## Use to Walk Character to Target Area
func walk_to(target: float, actor: CharacterBody2D) -> bool:
	var speed = actor.speed
	var distance := target - actor.global_position.x
	
	if abs( distance ) > 2:
		actor.velocity.x = sign( distance ) * speed
		return false
	
	actor.velocity.x = move_toward(actor.velocity.x, 0, speed)
	
	if actor.velocity.x == 0:
		return true
	
	return false


## Portal Appears
func portal_appear(portal_location: Marker2D, auto: bool = false, normal: bool = true, entry_time: int = 0) -> void:
	var portal_scene = ResourceLoader.load(portal_path, "PackedScene") as PackedScene
	portal = portal_scene.instantiate()
	portal.global_position = portal_location.global_position
	object_container.add_child(portal)
	portal.isNormal = normal
	if !portal.isNormal:
		portal.entry_time = entry_time
	portal.auto_dissapp = auto
	portal.z_index = -11
	portal.appear()


## Portal_dissapears
func portal_diss() -> bool:
	if portal:
		portal.dissappear()
		return true
	return false


## Can be Used for dissappearing CharacterBody2D
func dissappear_character(character: CharacterBody2D) -> void:
	var tween = create_tween()
	tween.tween_property(character, "modulate:a", 0, 0.2)


func camera_switch_to(camera: Camera2D, status: bool) -> void:
	camera.enabled = status

## Main boss Appears
func main_boss_appears() -> void:
	var new_scene = ResourceLoader.load(main_boss_path, "PackedScene") as PackedScene
	main_boss = new_scene.instantiate()
	await get_tree().create_timer(2).timeout
	main_boss.modulate.a = 0
	main_boss.global_position = main_boss_sp.global_position
	entity.add_child(main_boss)
	await fade_in(main_boss)
	portal_diss()


## Setup the Scenes before Starting
func start_scene(scene: Scenes) -> void:
	match scene:
		Scenes.SCENE_1:
			set_target(girl, girl.right_dir);
		Scenes.SCENE_2:
			set_target(girl, girl.left_dir)
		Scenes.SCENE_3:
			main_boss_appears()
		Scenes.SCENE_4:
			set_target(main_boss, -125)
		Scenes.SCENE_5:
			main_boss.play_attack_animation(2)
			await get_tree().create_timer(0.8).timeout
			girl._play_dead()
			await get_tree().create_timer(2).timeout
			main_boss.turn_to("right")
		Scenes.SCENE_6:
			portal_appear(portal_sp_2)
			await get_tree().create_timer(2).timeout
			dissappear_character(player)
			await get_tree().create_timer(1).timeout
			portal_diss()
		Scenes.SCENE_7:
			portal_appear(portal_sp_3)
		Scenes.SCENE_8:
			await get_tree().create_timer(1).timeout
			dissappear_character(girl)
			dissappear_character(main_boss)
			await get_tree().create_timer(2).timeout
			portal_diss()
			animation_player.play("fade_in")
		Scenes.SCENE_9:
			portal_appear(portal_sp_4, true, false, 3)
			await get_tree().create_timer(2).timeout
			create_tween().tween_property(player, "modulate:a", 1, 0.2)
			player.active_gravity = true
			scene_running = false


#region scenes
## scene 1
func scene_1(_delta: float) -> void:
	if walk_to(target_distance,  girl):
		start_scene(Scenes.SCENE_2);
		curr_scene = Scenes.SCENE_2


## Scene 2
func scene_2(_delta: float) -> void:
	if walk_to(target_distance, girl):
		portal_appear(portal_sp)
		girl.turn_to(1);
		start_scene(Scenes.SCENE_3)
		curr_scene = Scenes.SCENE_3


## Scene 3
func scene_3() -> void:
	if portal == null:
		start_scene(Scenes.SCENE_4)
		curr_scene = Scenes.SCENE_4


## Scene 4
func scene_4() -> void:
	# In this scene main boss goes towards the girl
	if walk_to(target_distance, main_boss):
		start_scene(Scenes.SCENE_5)
		curr_scene = Scenes.SCENE_5


## Scene 5
func scene_5() -> void:
	if(walk_to(portal_sp_2.global_position.x, player)):
		start_scene(Scenes.SCENE_6)
		curr_scene = Scenes.SCENE_6


## Scene 6
func scene_6() -> void:
	if portal == null:
		start_scene(Scenes.SCENE_7)
		curr_scene = Scenes.SCENE_7


func scene_7() -> void:
	if(walk_to(girl.global_position.x, main_boss)):
		start_scene(Scenes.SCENE_8)
		curr_scene = Scenes.SCENE_8


func scene_8() -> void:
	if scene_running:
		return
	
	scene_running = true
	await animation_player.animation_finished
	player.active_gravity = false
	player.global_position = portal_sp_4.global_position
	camera_switch_to(cam, false)
	player.activate_camera()
	await get_tree().create_timer(3).timeout
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	start_scene(Scenes.SCENE_9)
	curr_scene = Scenes.SCENE_9


func scene_9() -> void:
	await get_tree().create_timer(2).timeout
	portal_diss()
	cut_scene_finished.emit()
	queue_free()


#endregion
