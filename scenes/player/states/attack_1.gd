extends State

@onready var attack_1_timer: Timer = $Attack1Timer

#------------------------------------------------------------------------------#
func enter_state(): #When attack1 starts
	animation_tree["parameters/conditions/attack1"] = true
	attack_1_timer.start() #Start timer
	animate_attack1()

func update_state(_delta: float):
	run()
#------------------------------------------------------------------------------#

func animate_attack1():
	animation_tree["parameters/attack1/blend_position"] = player.last_direction

func run():
	player.velocity = player.direction * player.speed * player.attack_multiplier
	player.move_and_slide()

func _on_attack_1_timer_timeout() -> void: #When timer ends
	animation_tree["parameters/conditions/attack1"] = false
	
	if player.direction == Vector2.ZERO:
		state_transition.emit(self, "idle") #Transition to Idle state
	
	elif player.direction != Vector2.ZERO:
		state_transition.emit(self, "run") #Transition to Run state
	
