extends Control

@export var scoreLabel : Label


func _ready() -> void:
	scoreLabel.text = '0'
	GlobalManager.update_score.connect(update_coin_score);


func _process(_delta: float) -> void:
	pass

func update_coin_score() -> void:
	scoreLabel.text = str(GlobalManager.score)
