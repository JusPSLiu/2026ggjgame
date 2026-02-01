extends Node2D
class_name obstacle

const center : float = 62.0

var myPos = 0

@export var stopForMask : int = -1
@export var hide_if_proper_mask : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	myPos = GlobalVariables.xpos + (global_position.x/global_scale.x) - center + get_parent().get_parent().offset
	# center ME, but uncenter my kids
	set_env_pos(GlobalVariables.xpos)
	position.x = center
	
	if (stopForMask != -1):
		hide_if_proper_mask.show()
		check_mask_collision(GlobalVariables.currMask)
		SignalBus.setmask.connect(check_mask_collision)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_env_pos(GlobalVariables.xpos)


func set_env_pos(pos : float):
	var newpos = myPos - pos
	position.x = newpos
	if (!visible):
		show()


func check_mask_collision(mask : int):
	if (mask == stopForMask):
		hide_if_proper_mask.hide()
		$LeftColliders.set_collision_layer_value(24, false)
	else:
		hide_if_proper_mask.show()
		$LeftColliders.set_collision_layer_value(24, true)
