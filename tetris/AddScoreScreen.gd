extends Control
# TODO: add alphabet picker

const max_chars: int = 6

var current_char: int = 0

func _ready():
	$Name/Label.text = ""
	for i in range(max_chars):
		$Name/Label.text += "_"

func is_alpha(ch):
	return (ch >= 'A' and ch <= 'Z') or (ch >= 'a' and ch <= 'z')

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.echo and event.pressed:
			if is_alpha(char(event.unicode)):
				if current_char == max_chars:
					# TODO: beep
					return
				$Name/Label.text[current_char] = char(event.unicode)
				current_char += 1
			if event.scancode == KEY_BACKSPACE:
				if current_char == 0:
					# TODO: beep
					return
				current_char -= 1
				$Name/Label.text[current_char] = "_"
				
