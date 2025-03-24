#class_name Player extends CharacterBody2D
extends CharacterBody2D

@onready var sprites: AnimatedSprite2D = $sprites
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine

@export var speed := 200
@export var dash_multiplier := 2.5
@export var attack_multiplier := 0.6

var direction: Vector2 = Vector2.ZERO #For move direction
var last_direction: Vector2 = Vector2(1, 1) #Mostly for animation's direction


func _physics_process(_delta: float) -> void:
	
	handle_direction()
	handle_last_direction()


func handle_direction():
	direction = Vector2(
		Input.get_axis("ui_left", "ui_right"), 
		Input.get_axis("ui_up", "ui_down")
	).normalized()

func handle_last_direction():
	# Assign last direction
	if direction.x != 0:
		last_direction.x = direction.x
	if direction.y != 0:
		last_direction.y = direction.y
