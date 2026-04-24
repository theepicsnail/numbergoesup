
extends Control

func _get_container(pos: Vector2i):
	return $VBoxContainer.get_child(pos.y).get_child(pos.x)
	
func get_cols()->int:
	return $VBoxContainer.get_child(0).get_child_count()
	
func get_rows()->int:
	return $VBoxContainer.get_child_count()
	
func get_cell(pos: Vector2i) -> Node:
	return _get_container(pos).get_child(0)

func set_cell(pos: Vector2i, val: Node):
	var container = _get_container(pos)
	for c in container.get_children():
		c.queue_free()
	container.add_child(val)
	

func add_row():
	var y = get_rows()
	var hbox = HBoxContainer.new()
	for x in range(get_cols()):
		var container = Control.new()
		container.name = "Container,%s,%s"%[x,y]
		container.custom_minimum_size = Vector2.ONE * 100
		hbox.add_child(container)
	$VBoxContainer.add_child(hbox)
		

func add_col():
	var x = get_cols()
	for y in range(get_rows()):
		var container = Control.new()
		container.name = "Container,%s,%s"%[x,y]
		container.custom_minimum_size = Vector2.ONE * 100
		$VBoxContainer.get_child(y).add_child(container)
