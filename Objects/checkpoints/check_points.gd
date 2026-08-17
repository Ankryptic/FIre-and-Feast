class_name Checkpoint
extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player_group"):
		return
	
	SaveLoad.save_data.player_location = {
		"x": body.global_position.x,
		"y": body.global_position.y
	}
	
	SaveLoad._save_game()
	queue_free()
