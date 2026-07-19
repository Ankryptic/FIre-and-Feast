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

const SPEED := 30.0
const JUMP_VELOCITY = -400.0

@export var left_dir := -50.0
@export var right_dir := 100.0

var curr_scene: Scenes = Scenes.SCENE_1
var target_distance: float
var pause: bool
var player_state: States = States.IDLE

@onready var actress: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	target_distance = global_position.x + right_dir

func _physics_process(delta: float) -> void:
	if pause:
		return
	
	match curr_scene:
		Scenes.SCENE_1:
			scene_1(delta)
			pass
	
	manage_state()
	
	move_and_slide()


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


## Use to Walk Character to Target Area
func walk_to(location: float, _delta: float) -> void:
	change_state(States.WALK)
	
	if location > global_position.x:
		velocity.x = SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x == 0:
		change_state(States.IDLE)


func scene_1(delta: float) -> void:
	walk_to(target_distance, delta)
