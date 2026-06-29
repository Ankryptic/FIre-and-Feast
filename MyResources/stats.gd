class_name Stats
extends Resource

@export var health : int :
	set(value) : healthUpdate(value)
	
@export var max_health : int 

func _init() -> void:
	pass

##Update the Owner health bar
func healthUpdate(value) -> void:
	health = clampi(value, 0, max_health)

func update_heatlh_bar() -> int:
	var health_percent := health / max_health * 100
	print(health_percent)
	return health_percent
