extends CharacterBody2D

@export var speed = 20.0

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Mask equipped: 0 = none, 1 = , 2 = , 3 = 
var mask = 0

var coyote = 0.1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() or coyote > 0:
		coyote -= delta
		velocity += get_gravity() * delta
	else:
		coyote = 0.1
	
	# handle speed (TODO: add raycast2d)
	GlobalVariables.xpos += delta * speed

	# Handles jump.
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up") and coyote > 0:
		velocity.y = JUMP_VELOCITY
	
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
		if mask == 0:
			# CHANGE THE CURRENT SPRITE FOR THE MASK
			pass
	
	if Input.is_action_just_pressed("mask_2"): # K
		if mask == 0:
			# CHANGE THE CURRENT SPRITE FOR THE MASK
			pass
	
	if Input.is_action_just_pressed("mask_3"): # L
		if mask == 0:
			# CHANGE THE CURRENT SPRITE FOR THE MASK
			pass

	move_and_slide()
