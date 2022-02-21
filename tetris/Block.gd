tool
extends Node2D

export(String, "red", "blue", "green", "yellow", "cyan", "magenta") var color

func _ready():
	for cell in get_children():
		cell.color = color
		cell.set_color()
