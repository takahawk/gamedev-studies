tool
extends Node2D

export(String, "red", "blue", "green", 
	   "yellow", "cyan", "magenta") var color

onready var cell_tex = preload("res://cell_red.png")

signal is_landed()

var game

func _ready():
	for cell in get_children():
		cell.color = color
		cell.set_color()
		

func set_game_position(dpos):
	set_position(cell_to_xy(dpos))
	for cell in get_children():
		cell.pos += dpos


func cell_to_xy(cell):
	return Vector2(cell.x * cell_tex.get_width(),
				   cell.y * cell_tex.get_height())


func set_game(game):
	self.game = game
	for cell in get_children():
		cell.set_game(game)


func can_move_left():
	var result = true
	for cell in get_children():
		result = result && cell.can_move_left()
	return result

	
func can_move_right():
	var result = true
	for cell in get_children():
		result = result && cell.can_move_right()
	return result
	
func can_move_down():
	var result = true
	for cell in get_children():
		result = result && cell.can_move_down()
	return result

	
func move_left():
	if can_move_left():
		for cell in get_children():
			cell.move_left()


func move_right():
	if can_move_right():
		for cell in get_children():
			cell.move_right()

func move_down():
	if can_move_down():
		for cell in get_children():
			cell.move_down()
	else:
		emit_signal("is_landed")
