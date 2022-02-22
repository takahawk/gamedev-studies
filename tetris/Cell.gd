tool
extends Sprite

export(String, "red", "blue", "green", 
	   "yellow", "cyan", "magenta") var color

onready var textures = {
	"red": preload("res://cell_red.png"),
	"blue": preload("res://cell_blue.png"),
	"green": preload("res://cell_green.png"),
	"cyan": preload("res://cell_cyan.png"),
	"yellow": preload("res://cell_yellow.png"),
	"magenta": preload("res://cell_magenta.png")
	}

export (Vector2) var pos
var game

func _ready():
	set_color()

func set_color():
	texture = textures[color]

func set_game(game):
	self.game = game

func can_move_left():
	return pos.x - 1 >= 0 and not game[pos.y][pos.x - 1]
	
func can_move_right():
	return pos.x + 1 < len(game[0]) and not game[pos.y][pos.x + 1]

func can_move_down():
	return pos.y + 1 < len(game) and not game[pos.y + 1][pos.x]

func move_right():
	assert(can_move_right())
	pos.x += 1
	position.x += texture.get_width()

	
func move_left():
	assert(can_move_left())
	pos.x -= 1
	position.x -= texture.get_width()

func move_down():
	assert(can_move_down())
	pos.y += 1
	position.y += texture.get_height()
