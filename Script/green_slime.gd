extends CharacterBody2D

#region Onready variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wall_detector: RayCast2D = $WallDetector
@onready var ledge_detector: RayCast2D = $LedgeDetector
@onready var timer: Timer = $Timer
#endregion

#region Normal Variables
var direction : float = 1.0
@export var speed : int = 20
@onready var green_slime: AnimatedSprite2D = $AnimatedSprite2D
#endregion

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if wall_detector.is_colliding():
		change_direction()
	
	print(direction)
	velocity.x += speed * direction * delta
	
	move_and_slide()


## Plays Hit Animation and Deal with Damage
func get_damage(hit_direction : int) -> void:
	speed = 0
	timer.start()
	animation_player.play('damage')
	position.x += 5 * hit_direction

func change_direction() -> void:
	direction *= -1
	green_slime.flip_h = true

func _on_timer_timeout() -> void:
	speed = 50
