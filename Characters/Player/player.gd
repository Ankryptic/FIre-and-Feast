class_name Player
extends CharacterBody2D

## This is Player Script

#region Enums
enum States {
	IDLE,
	WALK,
	RUN
}
#endregion

#region CONSTANTS
const JUMP_VELOCITY = -300.0
#endregion 

#region Export variables
@export var camera_2d: Camera2D
@export var PlayerStat : Stats
#endregion

const RUN_SPEED := 80

#region regular variables
var speed := 40.0
var active_spawn_point : Node = right_spawn_point
var in_cutscene := false
var player_state: States = States.IDLE
var active_gravity: bool = true
#endregion

#region Onready variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var projectile := preload("uid://bqbsoy4gs1ghh")
@onready var right_spawn_point: Marker2D = $RightSpawnPoint
@onready var left_spawn_point: Marker2D = $LeftSpawnPoint
@onready var projectiles: Node = %Projectiles
#endregion

func _ready() -> void:
	set_camera_limit()

func _process(_delta: float) -> void:
	if !in_cutscene:
		handle_projectile()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	add_gravity(delta)
	
	
	## Handle the player control according to the cutscene
	if in_cutscene:
		cutscene_movement_control()
	elif !in_cutscene:
		var direction := Input.get_axis("move_left", "move_right")
		
		handle_movement(direction)
		handle_jump()
		handle_animation(direction)
	
	manage_state()
	move_and_slide()


func add_gravity(delta: float) -> void:
	if not active_gravity:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor(): 
		velocity.y = JUMP_VELOCITY


## Control Movement by Player
func handle_movement(direction: float) -> void:
	if direction:
		if direction == -1:
			turn_to(false)
		else:
			turn_to()
		velocity.x = direction * RUN_SPEED
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, RUN_SPEED)


## Control Movement by cutscene
func cutscene_movement_control() -> void:
	if velocity.x == 0:
		change_state(States.IDLE)
	elif abs(velocity.x) > 0:
		change_state(States.RUN)
		
		if sign(velocity.x) == 1:
			turn_to()
		else:
			turn_to(false)


func handle_animation(direction : float) -> void:
	if is_on_floor():
		if direction == 0:
			change_state(States.IDLE)
		else:
			change_state(States.RUN)
	else:
		animated_sprite.play("Jump")


## Changes the Player current State
func change_state(next_state: States ) -> void:
	if player_state == next_state:
		return
	else:
		player_state = next_state


## Manages the Current State of the Actress
func manage_state() -> void:
	match player_state:
		States.IDLE:
			animated_sprite.play("Idle")
		States.WALK:
			animated_sprite.play("")
		States.RUN:
			animated_sprite.play("Run")


func handle_projectile() -> void:
	if Input.is_action_just_pressed("shoot"):
		var melee = projectile.instantiate();
		
		if animated_sprite.flip_h:
			active_spawn_point = left_spawn_point
			melee.direction = -1
		else:
			active_spawn_point = right_spawn_point
			melee.direction = 1
		
		melee.global_position = active_spawn_point.global_position
		projectiles.add_child(melee)


func turn_to(right: bool = true) -> void:
	if right:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true


func activate_camera(status: bool = true) -> void:
	if camera_2d != null:
		camera_2d.enabled = status
	else:
		push_error("Camera not found ", camera_2d)


func set_camera_limit() -> void:
	camera_2d.limit_left = -250
	camera_2d.limit_bottom = 200
	camera_2d.limit_right = 2236
