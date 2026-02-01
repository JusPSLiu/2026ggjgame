extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.setmask.connect(set_mask)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_mask(index : int):
	var i = 0
	for child in get_children():
		if (index == i):
			child.position.y = 10
		else: child.position.y = 0
		i+=1
