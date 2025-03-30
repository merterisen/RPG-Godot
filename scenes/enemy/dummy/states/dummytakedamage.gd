class_name DummyTakeDamageState extends State

@onready var rootsprite: Sprite2D = $"../../rootsprite"
@onready var sprite: Sprite2D = $"../../rootsprite/sprite"
@onready var hitflash: Sprite2D = $"../../rootsprite/hitflash"
@onready var healthbar: ProgressBar = $"../../healthbar"

@onready var dummy: CharacterBody2D = $"../.."

@onready var takedamagetimer: Timer = $takedamagetimer
@onready var hitflashtimer: Timer = $hitflashtimer

var pending_damage: float = 0.0
var knockback_direction: Vector2
var knockback_speed: float

#------------------------------------------------------------------------------#
func enter_state():
	pass

func update_state(_delta: float):
	pass
#------------------------------------------------------------------------------#

## Player must trigger this function from it's code
## Handles timer's wait time, damage and knockback variables
func take_damage_settings(player_animation_duration: float, player_attack_damage: float, knockback_dir: Vector2, knockback_spd: float) -> void:
	hitflashtimer.wait_time = player_animation_duration * (0.2/0.25)
	hitflashtimer.start()
	
	takedamagetimer.wait_time = player_animation_duration 
	takedamagetimer.start()
	
	pending_damage = player_attack_damage
	
	knockback_direction = knockback_dir
	knockback_speed = knockback_spd

func knockback() -> void:
	dummy.velocity = knockback_direction * knockback_speed
	dummy.move_and_slide()

func hit_flash() -> void:
	hitflash.visible = true
	sprite.visible = false
	
	#Freeze the Game for a 0.1 sec
	Engine.time_scale = 0.00
	await get_tree().create_timer(0.05, true, false, true).timeout
	Engine.time_scale = 1.0
	
	hitflash.visible = false
	sprite.visible = true
	rootsprite.modulate = Color.RED # Make the sprite Red


func _on_hitflashtimer_timeout() -> void:
	healthbar.value -= pending_damage
	hit_flash()
	knockback()

func _on_takedamagetimer_timeout() -> void:
	state_transition.emit(self, "idle")
