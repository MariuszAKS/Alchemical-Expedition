extends Area2D


@export var damage:int = 2

@onready var collider:CollisionShape2D = get_node("Collider")
@onready var sprite:Sprite2D = get_node("Animation")
@onready var attack_timer:Timer = get_node("AttackTimer")
@onready var cooldown_timer:Timer = get_node("CooldownTimer")


func _ready():
	get_parent().attack_button_pressed.connect(_attack)
	collider.disabled = true
	sprite.visible = false


func _attack():
	if attack_timer.time_left == 0 and cooldown_timer.time_left == 0:
		collider.disabled = false
		sprite.visible = true
		attack_timer.start()

func _finish_attack():
	collider.disabled = true
	sprite.visible = false
	cooldown_timer.start()

func _hit(area:Area2D):
	print(area)
	if area is Hitbox:
		area.hit(damage)
