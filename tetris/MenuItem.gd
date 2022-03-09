extends Label

var default_color: Color
var entered: bool = false
export var on_hover_color: Color
export var on_click_color: Color

signal clicked()
signal unclicked()

func _ready() -> void:
	default_color = get("custom_colors/font_color")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("clicked", self, "_on_clicked")
	connect("unclicked", self, "_on_unclicked")
	
func _input(event: InputEvent) -> void:
	if !entered:
		return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				emit_signal("clicked")
			else:
				emit_signal("unclicked")

func _on_mouse_entered() -> void:
	entered = true
	set("custom_colors/font_color", on_hover_color)
	
func _on_mouse_exited() -> void:
	entered = false
	set("custom_colors/font_color", default_color)
	
func _on_clicked() -> void:
	set("custom_colors/font_color", on_click_color)
	
func _on_unclicked() -> void:
	set("custom_colors/font_color", default_color)
