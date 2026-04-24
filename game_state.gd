extends Node

var _board:Dictionary[Vector2i,TileBase] = {}

func pos_to_tile(pos:Vector2i)->TileBase:
	return _board.get(pos)
	
func tile_to_pos(tile:TileBase)->Vector2i:
	return _board.find_key(tile)

func set_tile(pos:Vector2i, tile:TileBase):
	_board[pos] = tile


signal on_event_chain_start()
signal on_event_chain_extended(cb:Callable)
signal on_event_chain_end()

func _ready():
	on_event_chain_end.connect(print.bind("Event chain end"))
	on_event_chain_start.connect(print.bind("Event chain start"))
	on_event_chain_extended.connect(func(cb):print("Event chain extend (%s) %s" % [_eventQueue.size(), cb]))

var _dequingEvents = false
var _eventQueue:Array[Callable]=  []
func enqueue(cb: Callable):
	_eventQueue.push_back(cb)
	on_event_chain_extended.emit(cb)

func _process(_delta: float) -> void:
	if _eventQueue:
		if not _dequingEvents:
			_dequingEvents = true
			on_event_chain_start.emit()
			
		var task = _eventQueue.pop_front()
		print(task)
		task.call()
		
		if _eventQueue.size() == 0:
			on_event_chain_end.emit()
			_dequingEvents = false
		
