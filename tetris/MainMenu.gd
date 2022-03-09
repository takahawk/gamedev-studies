extends Control

func _ready() -> void:
	$Exit.connect("unclicked", self, "_on_exit")


func _on_exit() -> void:
	get_tree().quit()
