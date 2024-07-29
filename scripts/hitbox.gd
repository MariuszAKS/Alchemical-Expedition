extends Area2D

class_name Hitbox


signal health_depleted

const MIN_POSSIBLE_LIFE:int = 1

@export var max_health:int
@export var health_left:int

@export var health_bar:ProgressBar


func _ready():
	max_health = max(max_health, MIN_POSSIBLE_LIFE)
	health_left = min(max(health_left, MIN_POSSIBLE_LIFE), max_health)

	health_bar.max_value = max_health
	_update_health_bar()


func heal(life):
	health_left += life
	health_left = min(health_left, max_health)
	_update_health_bar()

func hit(damage):
	health_left -= damage
	health_left = max(health_left, 0)
	_update_health_bar()

	if health_left <= 0:
		_death()

func _update_health_bar():
	health_bar.value = health_left

func _death():
	emit_signal(health_depleted.get_name())
	print("Died")
