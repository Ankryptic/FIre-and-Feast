extends CharacterBody2D

## Purple Slime Script

signal change_player_detector_direction(dir: int)

#region Onready variables
@onready var body: AnimatedSprite2D = $PurpleSlimeBody
@onready var wall_detector: RayCast2D = $PathDetectors/WallDetector
@onready var ledge_detector: RayCast2D = $PathDetectors/LedgeDetector
@onready var healthbar: TextureProgressBar = $Healthbar
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var hurtbox: Hurtbox = $PurpleSlimeBody/Hurtbox
@onready var enemy_hitbox: EnemyHitBox = $PurpleSlimeBody/EnemyHitBox
@onready var player_detector: Area2D = $PurpleSlimeBody/PlayerDetector
#endregion

#region Resource variables
@export var stat : Stats
@export var damage: int = 15
#endregion

#region Normal Variables
var direction : float = 1.0
var knock_back : float = 0.0
var isDead := false
@export var speed : float = 40.0
#endregion

func _ready() -> void:
	stat.initialize()
	healthbar.max_value = stat.max_health
	healthbar.value = stat.health
	stat.updated_health.connect(update_heath_bar)
	stat.dead.connect(play_dead)

func _physics_process(delta: float) -> void:
	if isDead:
		healthbar.visible = false
		return
	
	setup_gravity(delta)
	collision_detector()
	
	velocity.x = speed * direction + knock_back
	knock_back = move_toward(knock_back, 0, 500 * delta)
	
	move_and_slide()

func setup_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func collision_detector() -> void:
	if wall_detector.is_colliding():
		change_direction()
		change_player_detector_direction.emit(direction)
	
	if !ledge_detector.is_colliding():
		change_direction()
		change_player_detector_direction.emit(direction)

func change_direction() -> void:
	wall_detector.target_position *= -1
	ledge_detector.position.x *= -1
	direction *= -1
	body.flip_h = !body.flip_h

## Plays Hit Animation and Deal with Damage
func get_damage(hit_direction : int) -> void:
	speed = 0.0
	if stat.health != 0:
		#animation_player.play('damage')
		print("HealthDown")
	knock_back = 80 * hit_direction
	await get_tree().create_timer(0.8).timeout
	speed = 40.0


func take_damage(amount: int) -> void:
	stat.health -= amount


func update_heath_bar(cur_health: int , _max_health: int) -> void:
	healthbar.value = cur_health

func play_dead() -> void:
	hurtbox.set_deferred("monitorable", false)
	isDead = true
	speed = 0
	velocity = Vector2.ZERO
	#animation_player.stop()
	body.play("dead")
	#await green_slime.animation_finished
	queue_free()
