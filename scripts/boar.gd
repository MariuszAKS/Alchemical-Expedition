extends CharacterBody2D


enum State {WANDER, PREPARE_CHARGE, CHARGE, FINISH_CHARGE, STUNNED}

const WALK_VELOCITY = 50.0
const CHARGE_VELOCITY = 300.0

@onready var wander_timer:Timer = get_node("WanderTimer")
@onready var prepare_charge_timer:Timer = get_node("PrepareChargeTimer")
@onready var max_charge_timer:Timer = get_node("MaxChargeTimer")
@onready var charge_cooldown_timer:Timer = get_node("ChargeCooldownTimer")
@onready var memory_timer:Timer = get_node("MemoryTimer")
var direction:Vector2 = Vector2(1, 0)

var boar_state:State = State.WANDER
var state_changed:bool = false

var target:Node2D = null
var charging:bool = false


func _process(delta):
	if boar_state == State.WANDER:
		velocity = direction * WALK_VELOCITY
		move_and_slide()
	
	elif boar_state == State.CHARGE:
		velocity = direction * CHARGE_VELOCITY
		var collision = move_and_collide(velocity * delta)

		if collision:
			_finish_charge()
	
	else:
		direction = (target.position - position).normalized()


func _change_state(new_state:State):
	_exit_state(boar_state)
	_enter_state(new_state)


func _exit_state(current_state:State):
	if current_state == State.WANDER:
		wander_timer.stop()

	elif current_state == State.PREPARE_CHARGE:
		prepare_charge_timer.stop()
		# stop animation for preparing charge
	
	elif current_state == State.CHARGE:
		max_charge_timer.stop()
		# stop animation for charging
	
	elif current_state == State.FINISH_CHARGE:
		charge_cooldown_timer.stop()
	
	elif current_state == State.STUNNED:
		charge_cooldown_timer.stop()
		# stop animation for stunned


func _enter_state(new_state:State):
	if new_state == State.WANDER:
		_change_wandering_direction()
		# start animation for wandering
	
	elif new_state == State.PREPARE_CHARGE:
		prepare_charge_timer.wait_time = 0.5 + randf() / 2.0
		prepare_charge_timer.start()
		# start animation for preparing charge (kopytkiem kop)
	
	elif new_state == State.CHARGE:
		max_charge_timer.wait_time = 1.0 + randf()
		max_charge_timer.start()
		# start animation for charging
	
	elif new_state == State.FINISH_CHARGE:
		charge_cooldown_timer.wait_time = 0.5 + randf() / 2.0
		charge_cooldown_timer.start()
		# start animation for tired
	
	elif new_state == State.STUNNED:
		charge_cooldown_timer.wait_time = 2.0 + randf()
		charge_cooldown_timer.start()
		# start animation for stunned
	
	boar_state = new_state


func _change_wandering_direction():
	direction = Vector2(randf() * 2.0 - 1.0, randf() * 2.0 - 1.0).normalized()
	wander_timer.wait_time = 2.0 + randf()
	wander_timer.start()


func _spot_target(body:Node2D):
	target = body
	# start animation for spotting (opened eye)

	_change_state(State.PREPARE_CHARGE)

func _stop_seeing_target(_body:Node2D):
	memory_timer.start()
	# start animation for spotting (closed eye)

func _forget_target():
	target = null
	# start animation for forgetting (question mark)

	_change_state(State.WANDER)


func _finish_preparing_charge():
	_change_state(State.CHARGE)

func _finish_charge():
	_change_state(State.FINISH_CHARGE)

func _finish_cooldown():
	_change_state(State.PREPARE_CHARGE)

func _hit_obstacle():
	_change_state(State.STUNNED)
