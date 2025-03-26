## Virtual base class for all states.
## Extend this class and override its methods to implement a state.
class_name State extends Node

@onready var player: CharacterBody2D = $"../.."
@onready var sprites: AnimatedSprite2D = $"../../rootsprite/sprites"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var state_machine: StateMachine = $".."


## Emitted when the state finishes and wants to transition to another state.
## Example use: state_transition.emit(self, "Idle")
signal state_transition

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter_state():
	pass

## Called by the state machine on the engine's main loop tick.
func update_state(_delta: float):
	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit_state():
	pass
