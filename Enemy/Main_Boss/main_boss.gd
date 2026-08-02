class_name MainBoss
extends CharacterBody2D

# 😡 Main Boss Script

enum States {
	IDLE,
	WALK,
	RUN,
	ATTACK,
}

@export var speed: float = 10.0
@export var jump_velocity: float = 12.0
@export var gravity_multiplier: int = 1

var npc_state: States = States.IDLE

@onready var health_component: HealthComponent = %HealthComponent
@onready var model: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	# Gravity
	gravity(delta)
	
	if velocity.x == 0:
		change_state(States.IDLE)
	elif abs(velocity.x) > 0:
		change_state(States.WALK)
		
		if sign(velocity.x) == -1:
			model.flip_h = true
		else:
			model.flip_h = false
	
	# Handle NPC States
	
	
	move_and_slide()


## Handle gravity
func gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * gravity_multiplier * delta;


func manage_state() -> void:
	match npc_state:
		States.IDLE:
			model.play("idle")
		States.RUN:
			model.play("run")
		States.WALK:
			model.play("walk")


## Changes NPC states to the current 
func change_state(state: States) -> void:
	if state == npc_state:
		return
	
	npc_state = state
