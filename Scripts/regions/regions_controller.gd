extends Node2D


var loadedAhead : float = 0

@export var DirtRegions : Array[Resource]
@export_group("DEBUG MODE")
@export var debugEnabled : bool = false
@export_enum("Dirt") var debugOnlyRegion = "Dirt"
@export var debugTestONLY : int

var lastRegion : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (!OS.has_feature("editor")):
		debugEnabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# LOAD MORE IF CAN SEE PAST
	while (GlobalVariables.xpos > loadedAhead):
		# TODO: RANDOMIZE KID
		var newkid
		if OS.has_feature("editor") and debugEnabled:
			# debug mode, select that one
			match(debugOnlyRegion):
				"Dirt": newkid = DirtRegions[debugTestONLY].instantiate()
		else:
			# randomize
			newkid = get_random_region()
		
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

func get_random_region():
	if (GlobalVariables.xpos < 10000):
		# under ten thousand units; dirt region
		return DirtRegions[region_number_generator(DirtRegions.size())].instantiate()

# number generator that WILL generate different number each time
func region_number_generator(max_size : int):
	var selection = 0
	if (lastRegion < max_size):
		# limit range one more than before, and add 1 to skip the last chosen number
		selection = randi_range(0, max_size-2)
		if (selection >= lastRegion): selection = (selection + 1) % (max_size-1)
	else:
		# just choose randomly
		selection = randi_range(0, max_size-1)

	# make sure selection is at least zero
	selection = max(selection, 0)
	lastRegion = selection

	return selection
