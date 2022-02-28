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
	return pos.x - 1 >= 0 and not game[pos.y][pos.x - 1]
	
func can_move_right() -> bool:
	return pos.x + 1 < len(game[0]) and not game[pos.y][pos.x + 1]

func can_move_down() -> bool:
	return pos.y + 1 < len(game) and not game[pos.y + 1][pos.x]


func move_right() -> void:
	assert(can_move_right())
	pos.x += 1
	position.x += texture.get_width()

	
func move_left() -> void:
	assert(can_move_left())
	pos.x -= 1
	position.x -= texture.get_width()

func move_down() -> void:
	assert(can_move_down())
	pos.y += 1
	position.y += texture.get_height()

func move_to(new_pos: Vector2) -> void:
	var dx: int = new_pos.x - pos.x
	var dy: int = new_pos.y - pos.y
	pos = new_pos
	position.x += texture.get_width() * dx
	position.y += texture.get_height() * dy
