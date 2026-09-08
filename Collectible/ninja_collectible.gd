extends Collectible

## NINJA STAR

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	super._ready()
	scale = Vector2(0.3, 0.3)
	sprite_2d.texture = item.texture
