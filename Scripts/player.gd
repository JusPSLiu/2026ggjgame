extends CharacterBody2D

@export var MAX_SPEED = 100.0
@export var DEATH_SPEED = 100.0
const JUMP_VELOCITY = -600.0
const GRAVITY_MULTIPLIER = 2.0

@onready var raycasts : Array[Node] = $Detector.get_children()
@onready var my_pos_x = global_position.x

# Mask equipped: 0 = none, 1 = fox, 2 = bird, 3 = computer
var mask = 0

var coyote = 0.1
var speed = 0
var dead : bool = false

func _ready():
	GlobalVariables.deathpos = -60
	GlobalVariables.xpos = 0


func _physics_process(delta: float) -> void:
	# DEATH WALL speed
	GlobalVariables.deathpos += delta*DEATH_SPEED
	
	# skip if dead
	if (dead): return
	
	# Add the gravity.
	if not is_on_floor() or coyote > 0:
		coyote -= delta
		var fallRate = 2
		if (velocity.y < 0):
			if (Input.is_action_pressed("ui_up")):
				fallRate = 0.8
			elif (Input.is_action_pressed("ui_down")):
				fallRate = 3.0
		else:
			if (Input.is_action_pressed("ui_up")):
				fallRate = 1.0
			else: fallRate = 2.0
		velocity += get_gravity() * delta * GRAVITY_MULTIPLIER * fallRate
	else:
		coyote = 0.1
	
	# handle speed
	# running in game, check if hit if not speed up to max speed
	if (hit_obstacle()): speed = 0
	else: speed = lerpf(speed, MAX_SPEED, delta*4.0)
	GlobalVariables.xpos += delta * speed
	
	# handle DEATH
	if (GlobalVariables.deathpos > GlobalVariables.xpos-20):
		SignalBus.died.emit()
		dead = true

	# Handles jump.
	if Input.is_action_pressed("ui_up") and coyote > 0:
		velocity.y = JUMP_VELOCITY
		coyote = 0
	
	# Handles crouch.
	if Input.is_action_just_pressed("ui_down"):
		self.global_scale.x = 6
		self.global_scale.y = 2
		self.global_position.y += ($CollisionShape2D.shape.height)
	if Input.is_action_just_released("ui_down"):
		self.global_scale.x = 4
		self.global_scale.y = 4
	
	# Handles mask switching.
	if Input.is_action_just_pressed("mask_1"): # J
		# CHANGE THE CURRENT SPRITE FOR THE MASK
		SignalBus.setmask.emit(0) # set the UI
	
	if Input.is_action_just_pressed("mask_2"): # K
		# CHANGE THE CURRENT SPRITE FOR THE MASK
		SignalBus.setmask.emit(1) # set the UI
		pass
	
	if Input.is_action_just_pressed("mask_3"): # L
		# CHANGE THE CURRENT SPRITE FOR THE MASK
		SignalBus.setmask.emit(2) # set the UI

	# slide (and reset position)
	move_and_slide()
	global_position.x = my_pos_x

func hit_obstacle():
	for ray in raycasts:
		if (ray.is_colliding()): return true
	return false
