tool
extends Node2D

export(String, "red", "blue", "green", "yellow", "cyan", "magenta") var color

func _ready():
	for cell in get_children():
		cell.color = color
		cell.set_color()


func get_rect():
	var start = Vector2()
	var end = Vector2()
	for cell in get_children():
		var rect2 = cell.get_rect()
		var pos2 = cell.get_position()
		rect2.position += pos2
		start.x = min(start.x, rect2.position.x)
		start.y = min(start.y, rect2.position.y)
		end.x = max(end.x, rect2.end.x)
		end.y = max(end.y, rect2.end.y)
	var rect = Rect2(start, end - start)
	return rect
