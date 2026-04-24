extends Control

signal upgrade_started
signal upgrade_selected

@onready var upgrade_slot_1: GrayButtonUpgradeDisplay = $UpgradeDialog/CenterContainer/Control/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/GreyButtonUpgradeDisplay
@onready var upgrade_slot_2: GrayButtonUpgradeDisplay = $UpgradeDialog/CenterContainer/Control/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/GreyButtonUpgradeDisplay2
@onready var upgrade_slot_3: GrayButtonUpgradeDisplay = $UpgradeDialog/CenterContainer/Control/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/GreyButtonUpgradeDisplay3
@onready var upgrade_description: RichTextLabel = %UpgradeDescription

func _ready() -> void:
	# $UpgradeButton.disabled = true
	$UpgradeDialog.visible = false
	EventReceiver.on_upgrade_ready.connect(enable_upgrade_button)

func enable_upgrade_button()->void:
	$UpgradeButton.disabled = false

func _on_upgrade_button_pressed() -> void:
	$UpgradeButton.disabled = true
	$UpgradeDialog.visible = true
	upgrade_started.emit()

func _on_upgrade_cancel_pressed() -> void:
	$UpgradeDialog.visible = false
	upgrade_selected.emit(null)

func _on_option_hovered(upgrade: GrayButtonConfig) -> void:
	upgrade_description.text = upgrade.description
	
func _on_option_selected(upgrade: GrayButtonConfig) -> void:
	upgrade_selected.emit(upgrade)
	$UpgradeDialog.visible = false
