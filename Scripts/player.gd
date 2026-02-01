extends CharacterBody2D

@export var MAX_SPEED = 100.0
@export var DEATH_SPEED = 100.0
@export var BIRD_JUMP = 1
@export var mask_textures : Array[Texture2D]

const JUMP_VELOCITY = -600.0
const GRAVITY_MULTIPLIER = 2.0

@onready var raycasts : Array[Node] = $Detector.get_children()
@onready var my_pos_x = global_position.x
@onready var animator : AnimationPlayer = $PlayerSprite/AnimationPlayer

# Mask equipped: 0 = none, 1 = fox, 2 = bird, 3 = computer
var mask = 0

var coyote = 0.1
var speed = 0
var dead : bool = false

func _ready():
	GlobalVariables.deathpos = -60
	GlobalVariables.xpos = 0
	
	# fox mask by default
	if mask != 1:
		# CHANGE THE CURRENT SPRITE FOR THE MASK
		SignalBus.setmask.emit(0) # set the UI
		mask = 1


func _physics_process(delta: float) -> void:
	# DEATH WALL speed
	GlobalVariables.deathpos += delta*DEATH_SPEED
	
	# skip if dead
	if (dead): return
	
	# Add the gravity.
	if not is_on_floor():
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
		velocity += get_gravity() * delta * GRAVITY_MULTIPLIER * fallRate * BIRD_JUMP
		# in air, play fall anim
		if (velocity.y > 0 and (!animator.is_playing() or animator.current_animation == "run")):
			animator.play("fall")
	else:
		coyote = 0.1
		# on ground, play run anim
		if (animator.current_animation != "run"):
			animator.play("run")
	
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
		animator.play("jump")
	
	# Handles crouch.
	if Input.is_action_just_pressed("ui_down"):
		self.global_scale.x = 6
		self.global_scale.y = 2
		self.global_position.y += ($CollisionShape2D.shape.height)
	if Input.is_action_just_released("ui_down"):
		self.global_scale.x = 4
		self.global_scale.y = 4
	
	#region Mask Switching.
	if Input.is_action_just_pressed("mask_1"): # J
		# Fox
		if mask != 1:
			# CHANGE THE CURRENT SPRITE FOR THE MASK
			$MaskSprite.texture = mask_textures[0]
			SignalBus.setmask.emit(0) # set the UI
			GlobalVariables.currMask = 0
			BIRD_JUMP = 1
			mask = 1
	
	if Input.is_action_just_pressed("mask_2"): # K
		# Bird
		if mask != 2:
			# CHANGE THE CURRENT SPRITE FOR THE MASK
			$MaskSprite.texture = mask_textures[1]
			SignalBus.setmask.emit(1) # set the UI
			GlobalVariables.currMask = 0
			BIRD_JUMP = 0.75
			mask = 2
	
	if Input.is_action_just_pressed("mask_3"): # L
		# Robot
		if mask != 3:
			# CHANGE THE CURRENT SPRITE FOR THE MASK
			$MaskSprite.texture = mask_textures[2]
			SignalBus.setmask.emit(2) # set the UI
			GlobalVariables.currMask = 0
			BIRD_JUMP = 1
			mask = 3
	#endregion
	
	# MASK PHYSICS QUIRKS
	match(mask):
		1: # Fox
			if is_on_floor():
				MAX_SPEED = 105
			else:
				MAX_SPEED = 100
		2: # Bird
			if !is_on_floor():
				MAX_SPEED = 105
			else:
				MAX_SPEED = 100
		_: # Default
			MAX_SPEED = 100
	
	# slide (and reset position)
	move_and_slide()
	global_position.x = my_pos_x

func hit_obstacle():
	for ray in raycasts:
		if (ray.is_colliding()): return true
	return false
