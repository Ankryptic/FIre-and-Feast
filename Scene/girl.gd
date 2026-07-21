extends CharacterBody2D

## Girl Character script

#region Enums
enum States {
	IDLE,
	WALK,
	RUN
}

enum Scenes{
	SCENE_1,
	SCENE_2
}
#endregion

const SPEED := 20.0
const JUMP_VELOCITY = -400.0

@export var left_dir := -50.0
@export var right_dir := 100.0

var curr_scene: Scenes = Scenes.SCENE_1
var pause: bool
var player_state: States = States.IDLE
var target_distance: float

@onready var actress: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	start_scene(Scenes.SCENE_1)

func _physics_process(delta: float) -> void:
	if pause:
		return

	manage_current_scene(delta)
	
	manage_state()
	
	move_and_slide()


## Manage the Current Scene 
func manage_current_scene(delta: float) -> void:
	match curr_scene:
		Scenes.SCENE_1:
			scene_1(delta)
		Scenes.SCENE_2:
			scene_2(delta)


## Handle Change in the Actress State
func change_state(next_state: States ) -> void:
	if player_state == next_state:
		return
	else:
		player_state = next_state


## Manages the Current State of the Actress
func manage_state() -> void:
	match player_state:
		States.IDLE:
			actress.play("idle")
		States.WALK:
			actress.play("walk")
		States.RUN:
			actress.play("run")


## set the desired location target and stores value in target_distance
func set_target(offset: float) -> void:
	target_distance = global_position.x + offset


## Use to Walk Character to Target Area
func walk_to(target: float) -> bool:
	change_state(States.WALK)
	
	var distance := target - global_position.x
	
	if abs( distance ) > 2:
		velocity.x = sign( distance ) * SPEED
		return false
	
	velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x == 0:
		change_state(States.IDLE)
		return true
	
	return false


## Setup the Scenes before Starting
func start_scene(scene: Scenes) -> void:
	match scene:
		Scenes.SCENE_1:
			set_target(right_dir);
		Scenes.SCENE_2:
			set_target(left_dir)


## scene 1
func scene_1(_delta: float) -> void:
	if walk_to(target_distance):
		start_scene(Scenes.SCENE_2);
		curr_scene = Scenes.SCENE_2


## Scene 2
func scene_2(_delta: float) -> void:
	actress.flip_h = true
	walk_to(target_distance)
