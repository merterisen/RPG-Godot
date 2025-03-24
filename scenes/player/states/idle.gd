class_name IdleState extends State

#------------------------------------------------------------------------------#
func enter_state():
	animation_tree["parameters/conditions/idle"] = true
	animate_idle()

func update_state(_delta: float):
	
	if Input.is_action_just_pressed("attack"): #Transition to attack state
		animation_tree["parameters/conditions/idle"] = false
		state_transition.emit(self, "attack")
		
	if player.direction != Vector2.ZERO: #Transition to run state
		# and not Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/idle"] = false
		state_transition.emit(self, "run")
	

#------------------------------------------------------------------------------#

func animate_idle():
	animation_tree["parameters/idle/blend_position"] = player.last_direction
