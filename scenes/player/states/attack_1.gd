class_name AttackState extends State

@onready var player: CharacterBody2D = $"../.."
@onready var sprites: AnimatedSprite2D = $"../../rootsprite/sprites"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var state_machine: StateMachine = $".."

@onready var hitboxright: Area2D = $"../../damagedealtarea/hitboxright"
@onready var hitboxleft: Area2D = $"../../damagedealtarea/hitboxleft"

@onready var attack_1_timer: Timer = $Attack1Timer
@onready var attack_2_timer: Timer = $Attack2Timer
@onready var attack_3_timer: Timer = $Attack3Timer
@onready var attack_in_queue := false

#------------------------------------------------------------------------------#
func enter_state(): #When attack1 starts
	animation_tree["parameters/conditions/attack1"] = true # Activate the attack1 animation in the animation tree
	animate_attack() # Trigger the attack animation
	attack()
	attack_1_timer.start() #Start attack1 timer


func update_state(_delta: float):
	run() #Move always
	
	if Input.is_action_just_pressed("attack"): # Combo Input
		attack_in_queue = true # Queue the next attack for a combo

#------------------------------------------------------------------------------#

func attack(): #Decides Attack's direction and forces enemy_statemachine to takedamage state.
	
	# Select the hitbox based on the player's last direction
	var hitbox: Area2D = hitboxright if player.last_direction.x > 0 else hitboxleft
	
	for area in hitbox.get_overlapping_areas(): # Check all overlapping areas in the hitbox
		if area.is_in_group("enemy_hurtbox"): # If the area belongs to an enemy hurtbox group
			var enemy = area.get_parent() # Get the enemy node
			var enemy_statemachine = enemy.get_node("StateMachine") # Access the enemy's state machine
			if enemy_statemachine: # If the enemy has a state machine
				enemy_statemachine.force_change_state("takedamage") #force it to change to takedamage state

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
		animate_attack()
		attack()
		attack_2_timer.start()

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
		animate_attack() 
		attack()
		attack_3_timer.start()

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
		animate_attack() 
		attack()
		attack_1_timer.start()
