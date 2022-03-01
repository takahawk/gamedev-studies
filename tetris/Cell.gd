tool
extends Sprite
class_name Cell

export(String, "red", "blue", "green", 
	   "yellow", "cyan", "magenta") var color

onready var textures: Dictionary = {
	"red": preload("res://cell_red.png"),
	"blue": preload("res://cell_blue.png"),
	"green": preload("res://cell_green.png"),
	"cyan": preload("res://cell_cyan.png"),
	"yellow": preload("res://cell_yellow.png"),
	"magenta": preload("res://cell_magenta.png")
	}

export (Vector2) var pos
var game: Array

func _ready() -> void:
	set_color()

func set_color() -> void:
	texture = textures[color]

func set_game(game: Array) -> void:
	self.game = game

func can_move_left() -> bool:
	return can_move_to(pos + Vector2(-1, 0))
	
func can_move_right() -> bool:
	return can_move_to(pos + Vector2(1, 0))
	
func can_move_down() -> bool:
	return can_move_to(pos + Vector2(0, 1))

func move_right() -> void:
	move_to(pos + Vector2(1, 0))
	
func move_left() -> void:
	move_to(pos + Vector2(-1, 0))

func move_down() -> void:
	move_to(pos + Vector2(0, 1))
	
func can_move_to(new_pos: Vector2) -> bool:
	if new_pos.x < 0 or new_pos.x >= len(game[0]):
		return false
	if new_pos.y < 0 or new_pos.y >= len(game):
		return false
	if game[new_pos.y][new_pos.x]:
		return false
	return true

func move_to(new_pos: Vector2) -> void:
	assert(can_move_to(new_pos))
	var dx: int = new_pos.x - pos.x
	var dy: int = new_pos.y - pos.y
	pos = new_pos
	position.x += texture.get_width() * dx
	position.y += texture.get_height() * dy
