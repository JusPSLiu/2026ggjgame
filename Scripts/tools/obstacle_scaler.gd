@tool
extends Node

@export var region_length = 1
@export_tool_button("Set Length to Specified", "AnimationAutoFit") var button = _funcy
@export_enum("Dirt Background") var background_type = "Dirt Background"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (!Engine.is_editor_hint()):
		for child in get_children():
			child.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _funcy():
	$Label.text = "Region Length: "+str(region_length)
	get_parent().length = region_length
	print("PARENT REGION LENGTH: ", get_parent().length)
	var backParent = get_parent().get_node("Background")
	var backs = backParent.get_children()
	var position : float = 0
	var currNum : float = 1
	# position and delete if necessary
	for child in backs:
		if (currNum > region_length):
			child.queue_free()
		else:
			child.position = Vector2(position, 0)
			position += 32
			currNum += 1
	# create and position if necessary
	while (currNum <= region_length):
		var child = create_new_back()
		# add to hierarchy
		backParent.add_child(child)
		child.owner = get_tree().edited_scene_root
		child.set_name("BackgroundUnit")
		
		# position properly
		child.position = Vector2(position, 0)
		position += 32
		currNum += 1

func create_new_back():
	var child
	match(background_type):
		"Dirt Background":
			child = load("res://Prefabs/Background/dirt_background_unit.tscn")
		_:
			child = load("res://Prefabs/Background/dirt_background_unit.tscn")
	child = child.instantiate()
	return child
