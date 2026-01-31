extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handles jump.
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handles crouch.
	if Input.is_action_just_pressed("ui_down"):
		self.scale.x = 6
		self.scale.y = 2
		self.position.y += ($CollisionShape2D.shape.height)
	if Input.is_action_just_released("ui_down"):
		self.scale.x = 4
		self.scale.y = 4

	move_and_slide()
