extends CharacterBody2D


const MOVE_VELOCITY = 150.0
const MOVE_VELOCITY_MAX = 200.0
const DASH_VELOCITY = 500.0
const DECELERATION = 1000.0

var direction:Vector2 = Vector2(1, 0)

var can_move:bool = true
var can_attack:bool = true

@onready var camera:Camera2D = get_node("Camera")
@onready var attack_collision:CollisionShape2D = get_node("AttackArea/CollisionShape2D")
@onready var dash_timer:Timer = get_node("DashTimer")
@onready var attack_timer:Timer = get_node("AttackTimer")
@onready var attack_cooldown_timer:Timer = get_node("AttackCooldownTimer")


func _ready():
	enable_camera(true)
	dash_timer.timeout.connect(_enable_move)
	attack_timer.timeout.connect(_finish_attack)
	attack_cooldown_timer.timeout.connect(_enable_attack)


func _physics_process(delta):
	_movement(delta)
	
	if can_attack and Input.is_action_just_pressed("attack"):
		_start_attack()


func _movement(delta):
	var new_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if Input.is_action_just_pressed("move_dash"):
		velocity = direction * DASH_VELOCITY
		can_move = false
		dash_timer.start()
	elif can_move && new_direction:
		direction = new_direction
		velocity = direction * MOVE_VELOCITY
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)
		velocity.y = move_toward(velocity.y, 0, DECELERATION * delta)

	move_and_slide()

func _enable_move():
	can_move = true


func _start_attack():
	attack_collision.set_disabled(false)
	can_attack = false
	attack_timer.start()

func _finish_attack():
	attack_collision.set_disabled(true)
	attack_cooldown_timer.start()

func _enable_attack():
	can_attack = true


func enable_camera(value:bool):
	camera.enabled = value
