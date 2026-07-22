extends CharacterBody2D

## Girl Character script

#region Enums
enum States {
	IDLE,
	WALK,
	RUN
}
#endregion

const SPEED := 20.0
const JUMP_VELOCITY = -400.0

@export var left_dir := -50.0
@export var right_dir := 100.0

var pause: bool
var player_state: States = States.IDLE

@onready var actress: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	if pause:
		return
	
	if velocity.x == 0:
		change_state(States.IDLE)
	elif abs(velocity.x) > 0:
		change_state(States.WALK)
		
		if sign(velocity.x) == -1:
			actress.flip_h = true
		else:
			actress.flip_h = false
	
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
