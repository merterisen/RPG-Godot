class_name DummyIdleState extends State

@onready var rootsprite: Sprite2D = $"../../rootsprite"
@onready var state_machine: StateMachine = $".."

#------------------------------------------------------------------------------#
func enter_state():
	rootsprite.modulate = Color(1, 1, 1, 1)

func Exit():
	pass
#------------------------------------------------------------------------------#
