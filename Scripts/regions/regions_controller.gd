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
		
		# offset the new kid
		newkid.offset = 260
		loadedAhead += (newkid.length)*32
		newkid.hide()
		add_child(newkid)
		
		# if this is the first one then jump ahead so doesnt look glitchy 
		if (GlobalVariables.xpos < 200):
			# initial jump ahead so skip the glitchiness
			GlobalVariables.xpos += 200
			GlobalVariables.deathpos += 200
