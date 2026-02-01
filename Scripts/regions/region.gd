extends Node2D

@export_storage var length = 0
var offset : float = 0

var delPos = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2.ONE
	delPos = GlobalVariables.xpos + length*32 + offset
	var kids = find_children("*", "obstacle")
	for kid in kids: kid.hide()
	show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (GlobalVariables.xpos > delPos):
		queue_free()
