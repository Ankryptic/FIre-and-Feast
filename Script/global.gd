class_name GlobalManagerClass
extends Node2D

signal update_score
var score:int = 0:
	set(value):
		score = value
		update_score.emit()

var GameControl : Node
