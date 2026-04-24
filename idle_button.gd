class_name IdleButton
extends Node2D

signal pressed

@export var label: String:
	set(new_value):
		$Button.text = new_value

@export var recharge_delay: float:
	set(new_value):
		%ProgressBar.value = new_value
		recharge_delay = %ProgressBar.value

@export var recharge_seconds: float = 1:
	set(new_value):
		recharge_seconds = new_value
		%ProgressBar.max_value = recharge_seconds

func _on_button_pressed() -> void:
	if recharge_delay <= 0:
		pressed.emit(self)
		recharge_delay = recharge_seconds

func _process(delta: float) -> void:
	recharge_delay -= delta
	
	
