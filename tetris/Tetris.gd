tool
extends Node2D

export (int, 4, 100) var cols
export (int, 4, 100) var rows
export (float, 1, 2000) var speed

# we assume that speed=120 means block ticks every second
const ONE_SECOND_DISTANCE = 120
const PRESSED_KEY_TIMEOUT = 0.15
const PRESSED_KEY_DOWN_TIMEOUT = 0.05

signal game_is_over
signal lines_destroyed(count)

onready var cell_tex: Texture = preload("res://cell_red.png")
onready var blocks: Array = [
	preload("res://O-Block.tscn"),
	preload("res://S-Block.tscn"),
	preload("res://Z-Block.tscn"),
	preload("res://T-Block.tscn"),
	preload("res://I-Block.tscn")
]
var colors: Array = ["red", "green", "blue", "cyan", "yellow", "magenta"]

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var game: Array = [[]]
var block: Block
var game_is_over: bool = false
var time_to_tick: float = 0

var left_timeout: float
var right_timeout: float
var down_timeout: float

func _ready():
	rng.randomize()
	new_game()
	new_block()

func _process(deltaTime: float) -> void:
	if game_is_over:
		return
	if Engine.editor_hint:
		return
	if Input.is_action_just_pressed("tetris_left"):
		block.move_left()
	elif Input.is_action_pressed("tetris_left"):
		if left_timeout > PRESSED_KEY_TIMEOUT:
			block.move_left()
			left_timeout = 0
		left_timeout += deltaTime
	else:
		left_timeout = 0
		
	if Input.is_action_just_pressed("tetris_right"):
		block.move_right()
	elif Input.is_action_pressed("tetris_right"):
		if right_timeout > PRESSED_KEY_TIMEOUT:
			block.move_right()
			right_timeout = 0
		right_timeout += deltaTime
	else:
		right_timeout = 0
	
	if Input.is_action_pressed("tetris_down"):
		if down_timeout > PRESSED_KEY_DOWN_TIMEOUT:
			block.move_down()
			down_timeout = 0
		down_timeout += deltaTime
	else:
		down_timeout = 0
	
	if Input.is_action_just_pressed("tetris_drop"):
		var current_block := block
		while current_block == block:
			block.move_down()
	
	if Input.is_action_just_pressed("tetris_rotate"):
		block.block_rotate()
	
	time_to_tick -= deltaTime
	if time_to_tick < 0:
		time_to_tick = ONE_SECOND_DISTANCE / speed
		block.move_down()
	
func new_game() -> void:
	game = []
	game.resize(rows)
	for i in range(len(game)):
		game[i] = []
		game[i].resize(cols)
	var width = cell_tex.get_width() * cols
	var height = cell_tex.get_height() * rows
	$Background.set_size(Vector2(width, height))


func new_block() -> void:
	block = get_random_item(blocks).instance()
	var color = get_random_item(colors)
	block.color = color
	add_child(block)
	block.connect("is_landed", self, "_on_landed")
	var pos = Vector2(cols / 2, 0)
	block.set_game_position(pos)
	block.set_game(game)
	if block.has_conflicting_positions():
		game_is_over = true
		emit_signal("game_is_over")
		return
	
	time_to_tick = ONE_SECOND_DISTANCE / speed

func get_random_item(arr: Array) -> Object:
	return arr[rng.randi_range(0, len(arr) - 1)]

func check_lines() -> void:
	var lines_to_check := 4
	var current_line := len(game) - 1
	var lines_destroyed := 0
	while lines_to_check != 0:
		var line_is_full := true
		for cell in game[current_line]:
			if not cell:
				line_is_full = false
				break
		if line_is_full:
			for cell in game[current_line]:
				cell.queue_free()
			var empty_row = []
			empty_row.resize(len(game[current_line]))
			for i in range(current_line, 0, -1):
				game[i] = empty_row
				for cell in game[i - 1]:
					if cell:
						cell.move_down()
				game[i] = game[i - 1]
			for i in range(len(game[0])):
				game[0][i] = null
			lines_destroyed += 1
		else:
			current_line -= 1
		lines_to_check -= 1
	if lines_destroyed != 0:
		emit_signal("lines_destroyed", lines_destroyed)

func _on_landed() -> void:
	for cell in block.get_children():
		var position = cell.position
		block.remove_child(cell)
		self.add_child(cell)
		cell.set_position(position + block.position)
		game[cell.pos.y][cell.pos.x] = cell
	block.queue_free()
	check_lines()
	new_block()
