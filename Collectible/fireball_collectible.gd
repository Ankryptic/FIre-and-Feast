extends Collectible

## FireBall

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	super._ready()
	scale = Vector2(0.02, 0.02)
	sprite_2d.texture = item.texture
