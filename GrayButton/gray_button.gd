class_name GrayButton
extends Panel

@export var config: GrayButtonConfig:
	set(new_config):
		config = new_config
		$Button.text = config.text
		%ProgressBar.max_value = config.base_delay

func _on_button_pressed() -> void:
	EventReceiver.on_manual_click.emit()
	fire()

func fire():
	if %ProgressBar.value != %ProgressBar.min_value:
		return
	EventReceiver.on_add_score.emit(config.points_per_click)
	%ProgressBar.value = %ProgressBar.max_value

func _process(delta: float) -> void:
	var v = %ProgressBar.value
	%ProgressBar.value -= delta
	if v > 0 and %ProgressBar.value == 0:
		EventReceiver.on_gray_button_ready.emit(self)
	
	
