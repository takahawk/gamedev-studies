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

signal took_position(pos)
signal freed_position(pos)

export (Vector2) var pos
var game

func _ready():
	set_color()

func set_color():
	texture = textures[color]

func set_game(game):
	self.game = game

func can_move_left():
	return pos.x - 1 >= 0 and not game[pos.x - 1][pos.y]
			
	
func can_move_right():
	return pos.x + 1 < len(game[0]) and not game[pos.x + 1][pos.y]

func move_right():
	assert(can_move_right())
	print("RIGHT BEFORE")
	print(game[0])
	print(game[1])
	emit_signal("freed_position", pos)
	pos.x += 1
	position.x += texture.get_width()
	emit_signal("took_position", pos)
	print("RIGHT AFTER")
	print(game[0])
	print(game[1])
	
func move_left():
	assert(can_move_left())
	print("LEFT BEFORE")
	print(game[0])
	print(game[1])
	emit_signal("freed_position", pos)
	pos.x -= 1
	position.x -= texture.get_width()
	emit_signal("took_position", pos)
	print("LEFT AFTER")
	print(game[0])
	print(game[1])
