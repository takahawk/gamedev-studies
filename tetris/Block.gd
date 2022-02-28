tool
extends Node2D
class_name Block

export(String, "red", "blue", "green", 
	   "yellow", "cyan", "magenta") var color
export(Array) var rotations
export(int) var rotation_phase

onready var cell_tex: Texture = preload("res://cell_red.png")

signal is_landed()

var game: Array
# cells in order
var cells: Array

func _ready() -> void:
	for i in range(1, 5):
		cells.push_back(get_node("Cell" + str(i)))
	for cell in cells:
		cell.color = color
		cell.set_color()

func set_game_position(dpos: Vector2) -> void:
	set_position(cell_to_xy(dpos))
	for cell in cells:
		cell.pos += dpos


func cell_to_xy(cell: Vector2) -> Vector2:
	return Vector2(cell.x * cell_tex.get_width(),
				   cell.y * cell_tex.get_height())


func set_game(game: Array) -> void:
	self.game = game
	for cell in cells:
		cell.set_game(game)


func can_move_left() -> bool:
	var result := true
	for cell in cells:
		result = result && cell.can_move_left()
	return result

	
func can_move_right() -> bool:
	var result := true
	for cell in cells:
		result = result && cell.can_move_right()
	return result
	
func can_move_down() -> bool:
	var result := true
	for cell in cells:
		result = result && cell.can_move_down()
	return result

	
func move_left() -> void:
	if can_move_left():
		for cell in cells:
			cell.move_left()


func move_right() -> void:
	if can_move_right():
		for cell in cells:
			cell.move_right()

func move_down() -> void:
	if can_move_down():
		for cell in cells:
			cell.move_down()
	else:
		emit_signal("is_landed")

func block_rotate() -> void:
	if len(rotations) == 0:
		return
	for i in range(len(cells)):
		var pos: Vector2 = cells[i].pos + rotations[rotation_phase][i]
		if game[pos.y][pos.x]:
			# can't rotate
			return
		cells[i].move_to(pos)
	rotation_phase += 1
	if rotation_phase >= len(rotations):
		rotation_phase = 0
