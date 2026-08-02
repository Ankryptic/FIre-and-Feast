class_name HealthComponent
extends Node

signal health_changed(curr_health: float, max_health: float)
signal died

@export var max_health := 100
var curr_health: float:
	set(value):
		curr_health = clampf(value, 0.0, max_health)


func _ready() -> void:
	curr_health = max_health


## Emit Health Changed Signal When Health Changed
func _emit() -> void:
	health_changed.emit(curr_health, max_health)


## takes damage from other and update health
func damage(amount: float) -> void:
	curr_health -= amount
	_emit()
	
	if curr_health == 0:
		died.emit()


## Heals the owner and update the current health
func heal(amount: float) -> void:
	curr_health += amount
	_emit()
