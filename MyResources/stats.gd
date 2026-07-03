class_name Stats
extends Resource

signal updated_health(cur_health : int, max_health : int)
signal dead

@export var max_health : int = 100
var health : int :
	set(value) : 
		health = clampi(value, 0, max_health)
		update_health_stat()

#func _init() -> void:
	#_setup_func.call_deferred()

func initialize() -> void:
	health = max_health

func update_health_stat() -> void:
	if health == 0:
		dead.emit()
	
	updated_health.emit(health, max_health)
