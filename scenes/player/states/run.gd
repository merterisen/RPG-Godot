class_name RunState extends State

#------------------------------------------------------------------------------#
func enter_state():
	animation_tree["parameters/conditions/run"] = true

func update_state(_delta: float):
	
	animate_run()	#Should be in update because when change direction without changing state,
					#want to update animation
	run()
	
	if Input.is_action_just_pressed("attack"): #Transition to attack state
		animation_tree["parameters/conditions/run"] = false
		state_transition.emit(self, "attack")
		
	
	if player.direction == Vector2.ZERO: #Transition to idle state
		animation_tree["parameters/conditions/run"] = false
		state_transition.emit(self, "idle")
		
	
	if Input.is_action_just_pressed("dash"): #Transition to dash state
		animation_tree["parameters/conditions/run"] = false
		state_transition.emit(self, "dash")
		
#------------------------------------------------------------------------------#

func animate_run():
	animation_tree["parameters/run/blend_position"] = player.last_direction

func run():
	player.velocity = player.direction * player.speed
	player.move_and_slide()
