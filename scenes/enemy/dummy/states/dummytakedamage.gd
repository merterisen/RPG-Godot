class_name DummyTakeDamageState extends State

@onready var rootsprite: Sprite2D = $"../../rootsprite"
@onready var sprite: Sprite2D = $"../../rootsprite/sprite"
@onready var hitflash: Sprite2D = $"../../rootsprite/hitflash"

@onready var takedamagetimer: Timer = $takedamagetimer
@onready var hitflashtimer: Timer = $hitflashtimer

#------------------------------------------------------------------------------#
func enter_state():
	hitflashtimer.start()
	takedamagetimer.start()

func update_state(_delta: float):
	pass
#------------------------------------------------------------------------------#

func _on_hitflashtimer_timeout() -> void:
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
