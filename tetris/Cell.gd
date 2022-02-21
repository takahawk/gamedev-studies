tool
extends Sprite

export(String, "red", "blue", "green", "yellow", "cyan", "magenta") var color

onready var textures = {
	"red": preload("res://cell_red.png"),
	"blue": preload("res://cell_blue.png"),
	"green": preload("res://cell_green.png"),
	"cyan": preload("res://cell_cyan.png"),
	"yellow": preload("res://cell_yellow.png"),
	"magenta": preload("res://cell_magenta.png")
	}


func _ready():
	set_color()

func set_color():
	texture = textures[color]
