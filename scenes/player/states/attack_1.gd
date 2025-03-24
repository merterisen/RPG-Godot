extends State

@onready var attack_1_timer: Timer = $Attack1Timer

#------------------------------------------------------------------------------#
func enter_state(): #When attack1 starts
	attack_1_timer.start() #Start timer


func update_state(_delta: float):
	animate_attack1()
	run()
#------------------------------------------------------------------------------#



func animate_attack1():
	if player.last_direction.y > 0:
		if player.last_direction.x > 0:
			animation_player.play("attack1standRD")
		elif player.last_direction.x < 0:
			animation_player.play("attack1standLD")

	elif player.last_direction.y < 0:
		if player.last_direction.x > 0:
			animation_player.play("attack1standRU") 
		elif player.last_direction.x < 0:
			animation_player.play("attack1standLU") 

func run():
	player.velocity = player.direction * player.speed * player.attack_multiplier
	player.move_and_slide()

func _on_attack_1_timer_timeout() -> void: #When timer ends
	state_transition.emit(self, "Idle") #Change to Idle
