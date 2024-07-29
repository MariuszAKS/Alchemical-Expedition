extends CharacterBody2D

class_name Player


signal attack_button_pressed

const MOVE_VELOCITY = 150.0
const MOVE_VELOCITY_MAX = 200.0
const DASH_VELOCITY = 500.0
const DECELERATION = 1000.0

var direction:Vector2 = Vector2(1, 0)

var _can_move:bool = true
var _can_attack:bool = true

@onready var camera:Camera2D = get_node("Camera")
@onready var dash_timer:Timer = get_node("DashTimer")


func _ready():
	enable_camera(true)
	dash_timer.timeout.connect(enable_move.bind(true))


func _physics_process(delta):
	_movement(delta)
	
	if _can_attack and Input.is_action_just_pressed("attack"):
		emit_signal(attack_button_pressed.get_name())


func _movement(delta):
	var new_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if _can_move && Input.is_action_just_pressed("move_dash"):
		velocity = direction * DASH_VELOCITY
		enable_move(false)
		dash_timer.start()
	elif _can_move && new_direction:
		direction = new_direction
		velocity = direction * MOVE_VELOCITY
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		velocity.y = move_toward(velocity.y, 0, DECELERATION * delta)

	move_and_slide()

func enable_move(value:bool):
	_can_move = value

func enable_attack(value:bool):
	_can_attack = value

func enable_camera(value:bool):
	camera.enabled = value
