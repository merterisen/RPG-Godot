#This is a generic finite_state_machine, it handles all states, 
#changes to this code will affect everything that uses a state machine!
class_name StateMachine extends Node

var states: Dictionary = {}
var current_state : State
@export var initial_state : State


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
		
	if initial_state:
		initial_state.enter_state()
		current_state = initial_state

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update_state(delta)

## State Change code for state machine setup.
## You don't use this, instead use state_transition
func change_state(source_state : State, new_state_name : String):
	if source_state != current_state:
		print("Invalid change_state trying from: " + source_state.name + " but currently in: " + current_state.name)
		#This typically only happens when trying to switch from death state following a force_change
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
		
	if current_state:
		current_state.exit_state()
		
	new_state.enter_state()
	current_state = new_state

#Use force_change_state cautiously, it immediately switches to a state regardless of any transitions.
#This is used to force us into a 'death state' when killed
func force_change_state(new_state : String):
	var newState = states.get(new_state.to_lower())
	
	if !newState:
		print(new_state + " does not exist in the dictionary of states")
		return
	
	if current_state == newState:
		print("State is same, aborting")
		return
		
	#NOTE Calling exit like so: (current_state.Exit()) may cause warnings when flushing queries, like when the enemy is being removed after death. 
	#call_deferred is safe and prevents this from occuring. We get the Exit function from the state as a callable and then call it in a thread-safe manner
	if current_state:
		var exit_callable = Callable(current_state, "Exit")
		exit_callable.call_deferred()
	
	newState.enter_state()
	current_state = newState
