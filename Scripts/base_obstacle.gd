extends Node2D
class_name obstacle

const center : float = 62.0

var myPos = 0

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
	position.x = newpos
	if (!visible):
		show()
