tool
extends Node2D

export (int, 4, 100) var cols
export (int, 4, 100) var rows
export (float, 1, 2000) var speed

# we assume that speed=120 means block ticks every second
const ONE_SECOND_DISTANCE = 120
const PRESSED_KEY_TIMEOUT = 0.15
const PRESSED_KEY_DOWN_TIMEOUT = 0.05

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
var block
var time_to_tick = 0

var left_timeout
var right_timeout
var down_timeout

func _ready():
	rng.randomize()
	new_game()
	new_block()

func _process(deltaTime):
	if Engine.editor_hint:
		return
	if Input.is_action_just_pressed("ui_left"):
		block.move_left()
	elif Input.is_action_pressed("ui_left"):
		if left_timeout > PRESSED_KEY_TIMEOUT:
			block.move_left()
			left_timeout = 0
		left_timeout += deltaTime
	else:
		left_timeout = 0
		
	if Input.is_action_just_pressed("ui_right"):
		block.move_right()
	elif Input.is_action_pressed("ui_right"):
		if right_timeout > PRESSED_KEY_TIMEOUT:
			block.move_right()
			right_timeout = 0
		right_timeout += deltaTime
	else:
		right_timeout = 0
	
	if Input.is_action_pressed("ui_down"):
		if down_timeout > PRESSED_KEY_DOWN_TIMEOUT:
			block.move_down()
			down_timeout = 0
		down_timeout += deltaTime
	else:
		down_timeout = 0
	
	time_to_tick -= deltaTime
	if time_to_tick < 0:
		time_to_tick = ONE_SECOND_DISTANCE / speed
		block.move_down()
	
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
	block = get_random_item(blocks).instance()
	var color = get_random_item(colors)
	block.color = color
	add_child(block)
	block.connect("is_landed", self, "_on_landed")
	var pos = Vector2(cols / 2, 0)
	block.set_game_position(pos)
	block.set_game(game)
	
	time_to_tick = ONE_SECOND_DISTANCE / speed

func get_random_item(arr):
	return arr[rng.randi_range(0, len(arr) - 1)]


func _on_landed():
	for cell in block.get_children():
		var position = cell.position
		block.remove_child(cell)
		self.add_child(cell)
		cell.set_position(position + block.position)
		game[cell.pos.y][cell.pos.x] = cell
	block.queue_free()
	new_block()
