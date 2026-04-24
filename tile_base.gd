class_name TileBase
extends RefCounted

class EventSource:
	var data:String
	func _init(data:String):
		self.data = data

class ManualClick extends EventSource:
	func _init():
		super("Manual Click")
		
class GrayProc extends EventSource:
	func _init(tile:TileBase):
		super("Gray proc %s" % tile)


func get_control_instance()->Control:
	return null

func run_tile_action(triggeringEvent: EventSource):
	pass



class ToggleTile extends TileBase:
	var node: Button 
	
	var num:int = 0:
		set(val):
			print(num)
			num = val
			node.text = "X".repeat(num)
			node.modulate = [Color.WHITE, Color.YELLOW, Color.ORANGE, Color.RED, Color.GREEN][val]
			# node.theme.set_color()
	
	func _init() -> void:
		self.node = Button.new()
		self.node.custom_minimum_size = Vector2(100,100)
		self.node.pressed.connect(self.run_tile_action.bind(ManualClick.new()))
		
		self.num = randi() % 4
	func get_control_instance()->Control:
		return self.node
	
	func run_tile_action(triggeringEvent: EventSource):
		self.num += 1
		if self.num >= 4:
			self.num -= 4 
			var pos = GameState.tile_to_pos(self)
			for offset in [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.UP]:
				var tile = GameState.pos_to_tile(pos+offset)
				if tile:
					GameState.enqueue(tile.run_tile_action.bind(GrayProc.new(self)))
			
