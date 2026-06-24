extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var value :int = 1

func _on_body_entered(_body: Node2D) -> void:
	GlobalManager.score += value 
	#GlobalManager.update_score.emit()
	animation_player.play("collect")
