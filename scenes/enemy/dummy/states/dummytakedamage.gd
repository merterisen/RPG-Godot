class_name DummyTakeDamageState extends State

@onready var rootsprite: Sprite2D = $"../../rootsprite"
@onready var takedamagetimer: Timer = $takedamagetimer
@onready var freezetimer: Timer = $freezetimer

#------------------------------------------------------------------------------#
func enter_state():
	freezetimer.start()
	takedamagetimer.start()


func update_state(_delta: float):
	pass
#------------------------------------------------------------------------------#

func _on_freezetimer_timeout() -> void:
	rootsprite.modulate = Color(1, 0, 0, 1) # Make the sprite Red
	Engine.time_scale = 0.00  # Slow Game Speed
	await get_tree().create_timer(0.1, true, false, true).timeout
	Engine.time_scale = 1.0  # Normal Game Speed

func _on_takedamagetimer_timeout() -> void:
	state_transition.emit(self, "idle")
