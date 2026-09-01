class_name Checkpoint
extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player_group"):
		return
	
	if SaveLoad.is_data_exist():
		var current_checkpoint = SaveLoad.save_data.current_checkpoint
		if current_checkpoint == name:
			queue_free()
			return
	
	var p_health_component = body.get_node("HealthComponent") as HealthComponent
	#var coin_collection: Array[String]
	
	SaveLoad.save_data.player_location = {
		"x": body.global_position.x,
		"y": body.global_position.y
	}
	
	SaveLoad.save_data.player_health = {
		"current_health": p_health_component.curr_health,
		"max_health": p_health_component.max_health
	}
	
	SaveLoad.save_data.current_checkpoint = name
	
	SaveLoad._save_game()
	print("Checkpoint")
	queue_free()
