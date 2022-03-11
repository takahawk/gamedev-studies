extends Node2D

var lines_scores = {
	1: 100,
	2: 300,
	3: 700,
	4: 1500
}

var score: int = 0

func _ready() -> void:
	$HUD/Score.text = "SCORE " + str(score)
	

func _on_Tetris_lines_destroyed(count):
	score += lines_scores[count]
	$HUD/Score.text = "SCORE " + str(score)
