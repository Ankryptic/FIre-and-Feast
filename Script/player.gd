class_name Player
extends CharacterBody2D

#region CONSTANTS
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
#endregion 

#region Export variables
@export var PlayerStat : Stats
#endregion

#region regular variables
var active_spawn_point : Node = right_spawn_point
#endregion

#region Onready variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var projectile := preload("res://Scene/fireball.tscn")
@onready var right_spawn_point: Marker2D = $RightSpawnPoint
@onready var left_spawn_point: Marker2D = $LeftSpawnPoint
@onready var projectiles: Node = %Projectiles
#endregion


func _process(_delta: float) -> void:
	handle_projectile()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	add_gravity(delta)

	# Handle jump.
	handle_jump()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	handle_movement(direction)
	
	# Play Animation
	handle_animation(direction)
	
	move_and_slide()


func add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor(): 
		velocity.y = JUMP_VELOCITY


func handle_movement(direction: float) -> void:
	if direction:
		if direction == -1:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
		velocity.x = direction * SPEED
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func handle_animation(direction : float) -> void:
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")


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
