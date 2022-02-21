tool
extends Node2D

export (int, 4, 100) var cols
export (int, 4, 100) var rows

onready var cell_tex = preload("res://cell_red.png")
onready var blocks = [
	preload("res://O-Block.tscn"),
	preload("res://S-Block.tscn"),
	preload("res://Z-Block.tscn"),
	preload("res://T-Block.tscn")
]
var colors = ["red", "green", "blue", "cyan", "yellow", "magenta"]

var rng = RandomNumberGenerator.new()
var game = [[]]

func _ready():
	rng.randomize()
	new_game()
	new_block()

	
func new_game():
	game = []
	game.resize(rows)
	for i in range(len(game)):
		game[i] = []
		game[i].resize(cols)
	var width = cell_tex.get_width() * cols
	var height = cell_tex.get_height() * rows
	$Background.set_size(Vector2(width, height))


func new_block():
	var block = get_random_item(blocks).instance()
	var color = get_random_item(colors)
	block.color = color
	var pos = cell_to_xy(Vector2(cols / 2, 0))
	block.set_position(pos)
	add_child(block)


func get_random_item(arr):
	return arr[rng.randi_range(0, len(arr) - 1)]


func cell_to_xy(cell):
	return Vector2(cell.x * cell_tex.get_width(),
				   cell.y * cell_tex.get_height())
