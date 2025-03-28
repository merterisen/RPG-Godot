class_name PlayerDashState extends State

@onready var player: CharacterBody2D = $"../.."
@onready var sprites: AnimatedSprite2D = $"../../rootsprite/sprites"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var state_machine: StateMachine = $".."

var dash_direction: Vector2
@onready var dash_timer: Timer = $DashTimer

#------------------------------------------------------------------------------#
func enter_state(): #When Dash Starts
	enter_state_settings()
	animate_dash()

func update_state(_delta):
	dash()
#------------------------------------------------------------------------------#

func enter_state_settings() -> void:
	dash_direction = player.direction #Take the player's last direction before dash
	sprites.modulate = Color(1, 1, 1, 0.4) #Make Transparent
	dash_timer.start() #Start Dash Timer

func dash() -> void:
	player.velocity = dash_direction * player.speed * player.dash_multiplier
	player.move_and_slide()

func animate_dash() -> void:
	animation_tree["parameters/conditions/dash"] = true
	# If there is no x axis dash direction, use the player's last x direction
	if dash_direction.x == 0:
		animation_tree["parameters/dash/blend_position"] = Vector2(player.last_direction.x, dash_direction.y)
	# Otherwise, use the current dash direction
	else:
		animation_tree["parameters/dash/blend_position"] = dash_direction

func _on_dash_timer_timeout() -> void: #When Dash Timer Ends
	sprites.modulate = Color(1, 1, 1, 1) #Make Untransparent
	animation_tree["parameters/conditions/dash"] = false
	state_transition.emit(self, "run") #Transition to run state
