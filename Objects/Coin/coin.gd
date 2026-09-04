extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("_emit_coin_Changed"):
			body._emit_coin_Changed()
		
		save_coin_name_in_player(body)
		
	animation_player.play("collect")


func save_coin_name_in_player(body: Player) -> void:
	var player = body
	player.coin_collection.push_back(name)
