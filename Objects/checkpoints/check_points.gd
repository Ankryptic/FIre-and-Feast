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
	
	# Save Player Position, Health, Weapon Collection
	body._set_player_location_to_file()
	body._set_player_health_to_file()
	body._set_weapon_collection()
	
	SaveLoad.save_data.current_checkpoint = name
	SaveLoad.save_data.coin_collected = body.coin_collection
	
	SaveLoad._save_game()
	print("Checkpoint")
	queue_free()
