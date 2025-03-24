class_name IdleState extends State

#------------------------------------------------------------------------------#
func enter_state():
	animate_idle()

func update_state(_delta: float):
	
	if Input.is_action_pressed("attack"):
		state_transition.emit(self, "Attack1")
	
	if player.direction != Vector2.ZERO and not Input.is_action_pressed("attack"): #Transition to move state
		state_transition.emit(self, "Run")
		

#------------------------------------------------------------------------------#

func animate_idle():
	if player.last_direction.y > 0:
		if player.last_direction.x > 0:
			animation_player.play("idleRD")
		elif player.last_direction.x < 0:
			animation_player.play("idleLD")

	elif player.last_direction.y < 0:
		if player.last_direction.x > 0:
			animation_player.play("idleRU") 
		elif player.last_direction.x < 0:
			animation_player.play("idleLU") 

	elif player.last_direction.y == 0:
		if player.last_direction.x > 0:
			animation_player.play("idleRD")
		elif player.last_direction.x < 0:
			animation_player.play("idleLD")
