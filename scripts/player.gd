extends CharacterBody2D


const MOVE_VELOCITY = 100.0
const MOVE_VELOCITY_MAX = 200.0
const DASH_VELOCITY = 500.0
const DECELERATION = 1000.0

var direction: Vector2 = Vector2(1, 0)

var can_move: bool = true

@onready var camera: Camera2D = get_node("Camera")
@onready var dash_timer: Timer = get_node("DashTimer")

@export var camera_enabled: bool


func _ready():
	camera.enabled = camera_enabled
	dash_timer.timeout.connect(_enable_move)


func _physics_process(delta):
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

	#print(velocity)
	move_and_slide()
	print(Engine.get_frames_per_second())


func _enable_move():
	can_move = true
