class_name GrayButtonUpgradeDisplay
extends Panel

signal upgrade_hovered(upgrade: GrayButtonConfig)
signal upgrade_selected(upgrade: GrayButtonConfig)

@export var config: GrayButtonConfig:
	set(new_config):
		config = new_config
		$Button.text = config.text
		%ProgressBar.max_value = config.base_delay

func _on_button_pressed() -> void:
	upgrade_selected.emit(self.config)
	
func _on_button_mouse_entered() -> void:
	upgrade_hovered.emit(self.config)
