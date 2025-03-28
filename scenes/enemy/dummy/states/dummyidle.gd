class_name DummyIdleState extends State

@onready var rootsprite: Sprite2D = $"../../rootsprite"
@onready var state_machine: StateMachine = $".."
@onready var dummy: CharacterBody2D = $"../.."

#------------------------------------------------------------------------------#
func enter_state():
	enter_state_settings()

func exit_state():
	pass
#------------------------------------------------------------------------------#

func enter_state_settings():
	dummy.velocity = Vector2.ZERO
	rootsprite.modulate = Color(1, 1, 1, 1)
