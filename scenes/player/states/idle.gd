class_name PlayerIdleState extends State

@onready var player: CharacterBody2D = $"../.."
@onready var sprites: AnimatedSprite2D = $"../../rootsprite/sprites"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var state_machine: StateMachine = $".."

#------------------------------------------------------------------------------#
func enter_state():
	animate_idle()

func update_state(_delta: float):
	check_attack()
	check_run()

#------------------------------------------------------------------------------#

func animate_idle() -> void:
	animation_tree["parameters/conditions/idle"] = true
	animation_tree["parameters/idle/blend_position"] = player.last_direction

func check_attack() -> void:
	if Input.is_action_just_pressed("attack"): #Transition to attack state
		animation_tree["parameters/conditions/idle"] = false
		state_transition.emit(self, "attack")

func check_run() -> void:
	if player.direction != Vector2.ZERO: #Transition to run state
		animation_tree["parameters/conditions/idle"] = false
		state_transition.emit(self, "run")
