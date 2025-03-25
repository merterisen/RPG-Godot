class_name AttackState extends State

@onready var attack_1_timer: Timer = $Attack1Timer
@onready var attack_2_timer: Timer = $Attack2Timer
@onready var attack_3_timer: Timer = $Attack3Timer
@onready var attack_in_queue := false

#------------------------------------------------------------------------------#
func enter_state(): #When attack1 starts
	animation_tree["parameters/conditions/attack1"] = true
	animate_attack()
	attack_1_timer.start() #Start attack1 timer


func update_state(_delta: float):
	run()
	
	if Input.is_action_just_pressed("attack"):
		attack_in_queue = true
#------------------------------------------------------------------------------#

func animate_attack():
	animation_tree["parameters/attack1/blend_position"] = player.last_direction
	animation_tree["parameters/attack2/blend_position"] = player.last_direction
	animation_tree["parameters/attack3/blend_position"] = player.last_direction

func run():
	player.velocity = player.direction * player.speed * player.attack_multiplier
	player.move_and_slide()


func _on_attack_1_timer_timeout() -> void: #When attack 1 timer ends
	animation_tree["parameters/conditions/attack1"] = false
	
	if attack_in_queue == false: #If not combo
		if player.direction == Vector2.ZERO:
			state_transition.emit(self, "idle") #Transition to Idle state
		
		elif player.direction != Vector2.ZERO:
			state_transition.emit(self, "run") #Transition to Run state
	
	elif attack_in_queue == true: #If Combo
		animation_tree["parameters/conditions/attack2"] = true #Transition to attack2 animation
		attack_in_queue = false
		attack_2_timer.start()
		animate_attack() 

func _on_attack_2_timer_timeout() -> void: #When attack 2 timer ends
	animation_tree["parameters/conditions/attack2"] = false
	
	if attack_in_queue == false: #If not combo
		if player.direction == Vector2.ZERO:
			state_transition.emit(self, "idle") #Transition to Idle state
		
		elif player.direction != Vector2.ZERO:
			state_transition.emit(self, "run") #Transition to Run state
	
	elif attack_in_queue == true: #If Combo
		animation_tree["parameters/conditions/attack3"] = true #Transition to attack2 animation
		attack_in_queue = false
		attack_3_timer.start()
		animate_attack() 

func _on_attack_3_timer_timeout() -> void: #When attack 3 timer ends
	animation_tree["parameters/conditions/attack3"] = false
	
	if attack_in_queue == false:
		if player.direction == Vector2.ZERO:
			state_transition.emit(self, "idle") #Transition to Idle state
		
		elif player.direction != Vector2.ZERO:
			state_transition.emit(self, "run") #Transition to Run state
	
	elif attack_in_queue == true:
		animation_tree["parameters/conditions/attack1"] = true
		attack_in_queue = false
		attack_1_timer.start()
		animate_attack() 
