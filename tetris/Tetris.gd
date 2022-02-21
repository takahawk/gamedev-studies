tool
extends Node2D

export (int) var cols
export (int) var rows

onready var cell_tex = preload("res://cell_red.png")
onready var blocks = [
	preload("res://O-Block.tscn"),
	preload("res://S-Block.tscn"),
	preload("res://Z-Block.tscn"),
	preload("res://T-Block.tscn")
]

func _ready():
	new_game()


func new_game():
	var width = cell_tex.get_width() * cols
	var height = cell_tex.get_height() * rows
	print(width)
	print(height)
	$Background.set_size(Vector2(width, height))
