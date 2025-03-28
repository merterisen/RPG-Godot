class_name DummyTakeDamageState extends State

@onready var rootsprite: Sprite2D = $"../../rootsprite"
@onready var sprite: Sprite2D = $"../../rootsprite/sprite"
@onready var hitflash: Sprite2D = $"../../rootsprite/hitflash"
@onready var healthbar: ProgressBar = $"../../healthbar"

@onready var takedamagetimer: Timer = $takedamagetimer
@onready var hitflashtimer: Timer = $hitflashtimer

var pending_damage: float = 0.0

#------------------------------------------------------------------------------#
func enter_state():
	pass

func update_state(_delta: float):
	pass
#------------------------------------------------------------------------------#

# Player triggers this function
func take_damage_settings(player_animation_duration: float, player_attack_damage: float) -> void:
	hitflashtimer.wait_time = player_animation_duration * (0.2/0.25)
	hitflashtimer.start()
	
	takedamagetimer.wait_time = player_animation_duration 
	takedamagetimer.start()
	
	pending_damage = player_attack_damage

func _on_hitflashtimer_timeout() -> void:
	healthbar.value -= pending_damage
	hit_flash()

func _on_takedamagetimer_timeout() -> void:
	state_transition.emit(self, "idle")

func knockback() -> void:
	pass

func hit_flash() -> void:
	hitflash.visible = true
	sprite.visible = false
	
	#Freeze the Game for a 0.1 sec
	Engine.time_scale = 0.00
	await get_tree().create_timer(0.1, true, false, true).timeout
	Engine.time_scale = 1.0
	
	hitflash.visible = false
	sprite.visible = true
	rootsprite.modulate = Color.RED # Make the sprite Red
