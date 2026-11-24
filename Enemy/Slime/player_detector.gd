extends Area2D

## Player Detector

@onready var coll_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	owner.change_player_detector_direction.connect(change_colllision_shape_direction)
	body_entered.connect(_on_player_entered)


func _on_player_entered(body: Node2D) -> void:
	if body.name != "Player":
		return;
	
	#print("Player entered: ", body.name);


func change_colllision_shape_direction(dir: int) -> void:
	if dir == 1:
		coll_shape.global_position.x += 50;
	elif dir == -1:
		coll_shape.global_position.x -= 50;
