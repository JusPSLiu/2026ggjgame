extends Node2D

@export var backSpeed : float = 0.5
@export var decorSpeed : float = 0.8

const center : float = 62.0

var myPos = 0
var popped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	myPos = GlobalVariables.xpos + (global_position.x/global_scale.x) - center + get_parent().get_parent().offset
	# center ME, but uncenter my kids
	set_env_pos(GlobalVariables.xpos)
	position.x = center


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_env_pos(GlobalVariables.xpos)


func set_env_pos(pos : float):
	var newpos = myPos - pos
	$Back.position.x = newpos * backSpeed
	$Decor.position.x = newpos * decorSpeed
	$Ground.position.x = newpos
	
	if (newpos * backSpeed < -88):
		queue_free()
	
	if (!popped and GlobalVariables.deathpos > myPos):
		popped = true
		$AnimationPlayer.play("fall")
