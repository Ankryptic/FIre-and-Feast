class_name Stats
extends Resource

signal update_health_bar(cur_health : int, max_health : int)

@export var max_health : int = 100
var health : int :
	set(value) : 
		health = clampi(value, 0, max_health)
		update_health_bar.emit(health, max_health)

#func _init() -> void:
	#_setup_func.call_deferred()

func initialize() -> void:
	health = max_health
