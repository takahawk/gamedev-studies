tool
extends Node2D

export(String, "red", "blue", "green", 
	   "yellow", "cyan", "magenta") var color

onready var cell_tex = preload("res://cell_red.png")

signal took_position(pos)
signal freed_position(pos)

func _ready():
	for cell in get_children():
		cell.color = color
		cell.set_color()
		cell.connect("took_position", self, "_on_took_position")
		cell.connect("freed_position", self, "_on_freed_position")


func set_game_position(dpos):
	set_position(cell_to_xy(dpos))
	for cell in get_children():
		cell.pos += dpos
		emit_signal("took_position", cell.pos)


func cell_to_xy(cell):
	return Vector2(cell.x * cell_tex.get_width(),
				   cell.y * cell_tex.get_height())

func _on_took_position(pos):
	emit_signal("took_position", pos)
	
func _on_freed_position(pos):
	emit_signal("freed_position", pos)
