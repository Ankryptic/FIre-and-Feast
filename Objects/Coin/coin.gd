extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("_emit_coin_Changed"):
			body._emit_coin_Changed()
	animation_player.play("collect")
