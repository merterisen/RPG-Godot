class_name DashState extends State

var dash_direction: Vector2
@onready var dash_timer: Timer = $DashTimer

#------------------------------------------------------------------------------#
func enter_state(): #When Dash Starts
	dash_direction = player.direction #Take the player's last direction before dash
	sprites.modulate = Color(1, 1, 1, 0.4) #Make Transparent
	dash_timer.start() #Start Dash Timer


func update_state(_delta):
	dash()
	animate_dash()
#------------------------------------------------------------------------------#


func _on_dash_timer_timeout() -> void: #When Dash Timer Ends
	sprites.modulate = Color(1, 1, 1, 1) #Make Untransparent
	state_transition.emit(self, "Idle") #End dash (Return to Idle)

func dash():
	player.velocity = dash_direction * player.speed * player.dash_multiplier
	player.move_and_slide()

func animate_dash():
	if dash_direction.y > 0:
		if dash_direction.x > 0:
			animation_player.play("dashRD")
		elif dash_direction.x < 0:
			animation_player.play("dashLD")
		elif dash_direction.x == 0:
			pass
			#if dash_direction.x > 0:
			#	animation_player.play("dashRD")
			#elif dash_direction.x < 0:
			#	animation_player.play("dashLD")

	elif dash_direction.y < 0:
		if dash_direction.x > 0:
			animation_player.play("dashRU") 
		elif dash_direction.x < 0:
			animation_player.play("dashLU") 
		elif dash_direction.x == 0:
			pass
			#if dash_direction.x > 0:
			#	animation_player.play("dashRU")
			#elif dash_direction.x < 0:
			#	animation_player.play("dashLU")
		
	elif dash_direction.y == 0:
		if dash_direction.x > 0:
			if player.last_direction.y > 0:
				animation_player.play("dashRD")
			elif player.last_direction.y < 0:
				animation_player.play("dashRU")
		elif dash_direction.x <0:
			if player.last_direction.y > 0:
				animation_player.play("dashLD")
			elif player.last_direction.y < 0:
				animation_player.play("dashLU")
