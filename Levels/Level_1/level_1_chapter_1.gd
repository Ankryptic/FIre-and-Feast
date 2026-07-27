extends Node2D

# Level 1 Chapter 1 CutScene

enum Scenes{
	SCENE_1,
	SCENE_2,
	SCENE_3,
	SCENE_4
}


#region characters and export variables
@export_group("Characters")
@export var player: Player
@export var main_boss: CharacterBody2D
@export var girl: CharacterBody2D

@export_group("")
@export var cam_speed := 10
#endregion

#region normal variables
var curr_scene: Scenes = Scenes.SCENE_1
var target_distance: float
#endregion

#region onready variables
@onready var cut_scene_manager: CutSceneManager = $".."
@onready var entry_portal: Node2D = $EntryPortal
@onready var cam: Camera2D = $Path2D/PathFollow2D/Camera2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
#endregion

func _physics_process(delta: float) -> void:
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


## set the desired location target and stores value in target_distance
func set_target(actor: CharacterBody2D, offset: float) -> void:
	target_distance = actor.global_position.x + offset


## Use to Walk Character to Target Area
func walk_to(target: float, actor: CharacterBody2D) -> bool:
	var speed = actor.SPEED
	var distance := target - actor.global_position.x
	
	if abs( distance ) > 2:
		actor.velocity.x = sign( distance ) * speed
		return false
	
	actor.velocity.x = move_toward(actor.velocity.x, 0, speed)
	
	if actor.velocity.x == 0:
		return true
	
	return false


## Setup the Scenes before Starting
func start_scene(scene: Scenes) -> void:
	match scene:
		Scenes.SCENE_1:
			set_target(girl, girl.right_dir);
		Scenes.SCENE_2:
			set_target(girl, girl.left_dir)
		Scenes.SCENE_3:
			pass



#region scenes
## scene 1
func scene_1(_delta: float) -> void:
	if walk_to(target_distance,  girl):
		start_scene(Scenes.SCENE_2);
		curr_scene = Scenes.SCENE_2


## Scene 2
func scene_2(_delta: float) -> void:
	if walk_to(target_distance, girl):
		start_scene(Scenes.SCENE_3)
		curr_scene = Scenes.SCENE_3


## Scene 3
func scene_3() -> void:
	pass

#endregion
