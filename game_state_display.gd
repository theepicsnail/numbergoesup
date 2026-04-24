extends Node2D
@onready var grid_container: GridContainer = $CanvasLayer/GridContainer



func _ready() -> void:
	# Setup the board
	for y in range(5):
		for x in range(5):
			var pos = Vector2i(x,y)
			var tile = TileBase.ToggleTile.new()
			GameState.set_tile(pos, tile)

	# Display board
	for y in range(5):
		for x in range(5):
			var ctrl = GameState.pos_to_tile(Vector2i(x,y)).get_control_instance()
			grid_container.add_child(ctrl)
