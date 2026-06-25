extends CharacterBody2D

#region Onready variables
@onready var green_slime: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wall_detector: RayCast2D = $WallDetector
@onready var ledge_detector: RayCast2D = $LedgeDetector
#endregion

#region Normal Variables
var direction : float = 1.0
var knock_back : float = 0.0
@export var speed : float = 40.0
#endregion

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if wall_detector.is_colliding():
		change_direction()
	
	if !ledge_detector.is_colliding():
		change_direction()
	
	velocity.x = speed * direction + knock_back
	knock_back = move_toward(knock_back, 0, 500 * delta)
	
	move_and_slide()

func change_direction() -> void:
	wall_detector.target_position *= -1
	ledge_detector.position.x *= -1
	direction *= -1
	green_slime.flip_h = !green_slime.flip_h

## Plays Hit Animation and Deal with Damage
func get_damage(hit_direction : int) -> void:
	speed = 0.0
	animation_player.play('damage')
	knock_back = 100 * hit_direction
	await get_tree().create_timer(0.8).timeout
	speed = 40.0
