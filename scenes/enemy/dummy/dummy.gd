extends CharacterBody2D

@onready var healthbar: ProgressBar = $healthbar

func _on_healthbar_value_changed(value: float) -> void:
	show_healthbar()

func show_healthbar():
	if healthbar.value < 100:
		healthbar.visible = true
