extends Node2D

var lines_scores = {
	1: 100,
	2: 300,
	3: 700,
	4: 1500
}

var score: int = 0
var game_is_over: bool = false

func _input(event: InputEvent):
	if not game_is_over:
		return
	if event is InputEventMouseButton:
		if event.pressed:
			# TODO: change to record score screen
			get_tree().change_scene("res://MenuScreen.tscn")

func _ready() -> void:
	$HUD/Score.text = "SCORE " + str(score)
	

func _on_Tetris_lines_destroyed(count):
	score += lines_scores[count]
	$HUD/Score.text = "SCORE " + str(score)


func _on_Tetris_game_is_over():
	game_is_over = true
	$HUD/GameOver.visible = true
