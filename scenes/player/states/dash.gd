class_name DashState extends State

var dash_direction: Vector2
@onready var dash_timer: Timer = $DashTimer

#------------------------------------------------------------------------------#
func enter_state(): #When Dash Starts
	dash_direction = player.direction #Take the player's last direction before dash
	animation_tree["parameters/conditions/dash"] = true
	sprites.modulate = Color(1, 1, 1, 0.4) #Make Transparent
	dash_timer.start() #Start Dash Timer


func update_state(_delta):
	dash()
	animate_dash()
#------------------------------------------------------------------------------#


func _on_dash_timer_timeout() -> void: #When Dash Timer Ends
	sprites.modulate = Color(1, 1, 1, 1) #Make Untransparent
	animation_tree["parameters/conditions/dash"] = false
	state_transition.emit(self, "run") #Transition to run state


func dash():
	player.velocity = dash_direction * player.speed * player.dash_multiplier
	player.move_and_slide()
	
func animate_dash():
	if dash_direction.x == 0:
		animation_tree["parameters/dash/blend_position"] = Vector2(player.last_direction.x, dash_direction.y)
	else:
		animation_tree["parameters/dash/blend_position"] = dash_direction
