extends Button

var can_equip: bool = false

@export var texture: Texture2D:
	set(value):
		texture = value
		icon = texture
		update_status()


func update_status() -> void:
	if texture:
		can_equip = true
	else:
		can_equip = false
