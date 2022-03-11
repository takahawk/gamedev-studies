extends Control

func _on_Play_unclicked():
	get_tree().change_scene("res://GameScreen.tscn")


func _on_Exit_unclicked():
	get_tree().quit()
