class_name Checkpoint
extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player_group"):
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
	
	SaveLoad._save_game()
	print("Checkpoint")
	queue_free()
