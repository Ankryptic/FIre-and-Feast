extends AnimatableBody2D

var wentUp : bool = false;
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_group"):
		timer.start()
	


func _on_timer_timeout() -> void:
	
	if wentUp:
		animation_player.play("down")
		wentUp = false
	else:
		animation_player.play("up")
		wentUp = true
