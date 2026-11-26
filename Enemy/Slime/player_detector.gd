extends Area2D

## Player Detector

signal player_detected;

@onready var coll_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	owner.change_player_detector_direction.connect(change_colllision_shape_direction)
	body_entered.connect(_on_player_entered)
	body_exited.connect(_on_player_exited)


func _on_player_entered(body: Node2D) -> void:
	if body.name != "Player":
		return;
	
	owner.stop = true
	player_detected.emit();


func _on_player_exited(body: Node2D) -> void:
	if body.name != "Player":
		return;
	
	owner.stop = false;


func change_colllision_shape_direction(dir: int) -> void:
	if dir == 1:
		coll_shape.global_position.x += 50;
	elif dir == -1:
		coll_shape.global_position.x -= 50;
