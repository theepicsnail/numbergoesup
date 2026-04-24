class_name BlueButton
extends Panel


func _on_button_pressed() -> void:
	EventReceiver.on_manual_click.emit()
	fire()

func fire():
	if %ProgressBar.value != %ProgressBar.min_value:
		return
	%ProgressBar.value = %ProgressBar.max_value
	
	
	

func _process(delta: float) -> void:
	%ProgressBar.value -= delta
	
	
