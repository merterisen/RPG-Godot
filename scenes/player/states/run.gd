class_name PlayerRunState extends State

@onready var player: CharacterBody2D = $"../.."
@onready var sprites: AnimatedSprite2D = $"../../rootsprite/sprites"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var state_machine: StateMachine = $".."

#------------------------------------------------------------------------------#
func enter_state():
	animation_tree["parameters/conditions/run"] = true

func update_state(_delta: float):
	#Should be in update because when change direction without changing state,
	#want to update animation
	animate_run()
	run()
	
	check_attack()
	check_idle()
	check_dash()
#------------------------------------------------------------------------------#

func animate_run() -> void:
	animation_tree["parameters/run/blend_position"] = player.last_direction

func run() -> void:
	player.velocity = player.direction * player.speed
	player.move_and_slide()


func check_attack() -> void:
	if Input.is_action_just_pressed("attack"): #Transition to attack state
		animation_tree["parameters/conditions/run"] = false
		state_transition.emit(self, "attack")

func check_idle() -> void:
	if player.direction == Vector2.ZERO: #Transition to idle state
		animation_tree["parameters/conditions/run"] = false
		state_transition.emit(self, "idle")

func check_dash() -> void:
	if Input.is_action_just_pressed("dash"): #Transition to dash state
		animation_tree["parameters/conditions/run"] = false
		state_transition.emit(self, "dash")
