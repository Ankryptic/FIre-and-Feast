class_name Checkpoint
extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player_group"):
		return
	
	# Avoid resave after respawn
	if SaveLoad.is_data_exist():
		var current_checkpoint = SaveLoad.save_data.current_checkpoint
		if current_checkpoint == name:
			queue_free()
			return
	
	#var coin_collection: Array[String]
	
	# Save Player Position and Player Health
	body._set_player_location_to_file()
	body._set_player_health_to_file()
	
	SaveLoad.save_data.current_checkpoint = name
	
	SaveLoad._save_game()
	print("Checkpoint")
	queue_free()
