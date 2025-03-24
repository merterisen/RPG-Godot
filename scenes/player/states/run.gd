class_name RunState extends State

#------------------------------------------------------------------------------#
func enter_state():
	pass

func update_state(_delta: float):
	
	if Input.is_action_pressed("attack"):
		state_transition.emit(self, "Attack1")
	
	animate_run()
	run()
	
	if player.direction == Vector2.ZERO: #Transition to idle state
		state_transition.emit(self, "Idle")
	
	if Input.is_action_just_pressed("dash"):
		state_transition.emit(self, "Dash")
#------------------------------------------------------------------------------#

func animate_run():
	if player.direction.y > 0:
		if player.direction.x > 0:
			animation_player.play("runRD")
		elif player.direction.x < 0:
			animation_player.play("runLD")
		elif player.direction.x == 0:
			if player.last_direction.x > 0:
				animation_player.play("runRD")
			elif player.last_direction.x < 0:
				animation_player.play("runLD")

	elif player.direction.y < 0:
		if player.direction.x > 0:
			animation_player.play("runRU") 
		elif player.direction.x < 0:
			animation_player.play("runLU") 
		elif player.direction.x == 0:
			if player.last_direction.x > 0:
				animation_player.play("runRU")
			elif player.last_direction.x < 0:
				animation_player.play("runLU") 
		
	elif player.direction.y == 0:
		if player.direction.x > 0:
			if player.last_direction.y > 0:
				animation_player.play("runRD")
			elif player.last_direction.y < 0:
				animation_player.play("runRU")
		elif player.direction.x <0:
			if player.last_direction.y > 0:
				animation_player.play("runLD")
			elif player.last_direction.y < 0:
				animation_player.play("runLU")

func run():
	player.velocity = player.direction * player.speed
	player.move_and_slide()
