extends Node2D


var loadedAhead : float = 0

@export var DirtRegions : Array[Resource]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# LOAD MORE IF CAN SEE PAST
	while (GlobalVariables.xpos > loadedAhead):
		# TODO: RANDOMIZE KID
		var newkid = DirtRegions[0].instantiate()
		newkid.offset = 160
		loadedAhead += (newkid.length)*32
		add_child(newkid)
