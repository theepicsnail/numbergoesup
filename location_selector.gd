extends Control

signal location_selected(id:Vector2i)

func add_col():
	%ButtonGrid.add_col()
	_regenerate_buttons()
func add_row():
	%ButtonGrid.add_row()
	_regenerate_buttons()

func _regenerate_buttons():
	for y in range(%ButtonGrid.get_rows()):
		for x in range(%ButtonGrid.get_cols()):
			var b = Button.new()
			b.custom_minimum_size = Vector2(100,100)
			b.set_meta("id", Vector2i(x,y))
			b.pressed.connect(_on_button_pressed.bind(b))
			%ButtonGrid.set_cell(Vector2(x,y), b)
	
func show_selector():
	self.visible = true
	
func _on_button_pressed(btn:Button):
	location_selected.emit(btn.get_meta("id",null))
	self.visible = false
	
