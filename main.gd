extends Node2D

signal upgrade_slot(upgrade:GrayButtonConfig, slot:Vector2i)
var score: int:
	set(new_value):
		score = new_value
		%ScoreDisplay.text = "%s"%new_value
		if score >= next_upgrade:
			EventReceiver.on_upgrade_ready.emit()

var next_upgrade: int:
	set(new_value):
		next_upgrade = new_value
		%NextUpgradeDisplay.text = "%s"%new_value
		if score >= next_upgrade:
			EventReceiver.on_upgrade_ready.emit()
			
var manual_clicks: int:
	set(new_value):
		manual_clicks = new_value
		%ManualClicksDisplay.text = "%s"%manual_clicks
		
func manual_click():
	manual_clicks +=1

func add_score(n):
	score += n

const BLUE_BUTTON_SCENE = preload("uid://bvtr3pdhlkpmt")
const GRAY_BUTTON_SCENE = preload("uid://bx2pt4d5fkis1")
func _ready() -> void:
	# Just make the boards 5x5. Maybe we'll add growing as a mechanic
	for i in range(4):
		$%ButtonGrid.add_col()
		$%ButtonGrid.add_row()
		$%LocationSelector.add_col()
		$%LocationSelector.add_row()
	
	next_upgrade = 10
	score = 0
	
	EventReceiver.on_add_score.connect(add_score)
	EventReceiver.on_upgrade_ready.connect(enable_upgrading)
	EventReceiver.on_manual_click.connect(manual_click)
	
	
	var starting_button:GrayButton = GRAY_BUTTON_SCENE.instantiate()
	starting_button.config = preload("uid://cumjt6og6eb1r")
	%ButtonGrid.set_cell(Vector2i(2,2), starting_button)
	
	
	%ButtonGrid.set_cell(Vector2i(2,3), BLUE_BUTTON_SCENE.instantiate())
	

func enable_upgrading():
	%UpgradeSystem.enable_upgrade_button()


var selected_upgrade;
func _on_upgrade_selected(upgrade:GrayButtonConfig) -> void:
	
	next_upgrade += next_upgrade/2
	print("Upgrade", upgrade)
	selected_upgrade = upgrade
	if upgrade:
		%LocationSelector.show_selector()
	

func _on_upgrade_location_selected(loc:Vector2i)->void:
	if selected_upgrade == null:
		return
	print(loc)
	print(selected_upgrade)
	var btn = GRAY_BUTTON_SCENE.instantiate()
	btn.config = selected_upgrade
	selected_upgrade = null
	print(btn)
	%ButtonGrid.set_cell(loc, btn)
	
	
	
# ↹  ⭿
