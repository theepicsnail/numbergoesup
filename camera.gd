extends Camera2D
#
#var dragging = false
#
#func change_zoom(delta: float) -> void:
	#var mouse_pos := get_global_mouse_position()
	#self.zoom *= delta
	#var new_mouse_pos := get_global_mouse_position()
	#self.position += mouse_pos - new_mouse_pos
	#
#func _input(event):
	#if dragging and  event is InputEventMouseMotion:
		#self.global_position -= event.relative / self.zoom
		#
	#if event is InputEventMouseButton:
		#if not event.is_pressed():
			#if event.button_index == MOUSE_BUTTON_LEFT:
				#dragging = false
		#if event.is_pressed():
			#if event.button_index == MOUSE_BUTTON_LEFT:
				#dragging = true
			#if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				#change_zoom(1.1)
			#if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				#change_zoom(1/1.1)
