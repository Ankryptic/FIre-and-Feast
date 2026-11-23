extends Area2D


func _ready() -> void:
	body_entered.connect(_on_player_entered)


func _on_player_entered(body: Node2D) -> void:
	if body.name != "Player":
		return;
	
	print("Player entered: ", body.name);
