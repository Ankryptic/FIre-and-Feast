class_name MainBoss
extends CharacterBody2D

# 😡 Main Boss Script

enum States {
	IDLE,
	WALK,
	RUN,
	ATTACK_1,
	ATTACK_2,
}

@export var speed: float = 30.0
@export var jump_velocity: float = 12.0
@export var gravity_multiplier: int = 1

var npc_state: States = States.IDLE
var custom_anim: bool = false

@onready var health_component: HealthComponent = %HealthComponent
@onready var model: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	model.animation_finished.connect(_on_animation_finished)


func _physics_process(delta: float) -> void:
	
	# Gravity
	gravity(delta)
	
	if !custom_anim:
		if velocity.x == 0:
			change_state(States.IDLE)
		elif abs(velocity.x) > 0:
			change_state(States.WALK)
			
			if sign(velocity.x) == -1:
				turn_to("left")
			else:
				turn_to("right")
	
	# Handle NPC States
	manage_state()
	
	move_and_slide()


## Handle gravity
func gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * gravity_multiplier * delta;


## Manage Current NPC state
func manage_state() -> void:
	match npc_state:
		States.IDLE:
			model.play("idle")
		States.RUN:
			model.play("run")
		States.WALK:
			model.play("walk")
		States.ATTACK_1:
			model.play("attack_1")
		States.ATTACK_2:
			model.play("attack_2")


## Changes NPC states to the current 
func change_state(state: States) -> void:
	if state == npc_state:
		return
	
	npc_state = state


## Change the Main Boss Facing Direction
func turn_to(dir: String) -> void:
	var direction = dir.to_lower()
	if direction == "right":
		model.flip_h = true
	elif direction == "left":
		model.flip_h = false


## Runs when Animation finished
func _on_animation_finished() -> void:
	if npc_state == States.ATTACK_1:
		custom_anim = false
		change_state(States.IDLE)
	elif npc_state == States.ATTACK_2:
		custom_anim = false
		change_state(States.IDLE)


## Plays Available Attack Animation
func play_attack_animation(Number: int) -> void:
	custom_anim = true
	
	match Number:
		1 : change_state(States.ATTACK_1)
		2 : change_state(States.ATTACK_2)
