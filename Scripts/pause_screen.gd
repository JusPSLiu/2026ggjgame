extends CanvasLayer

var pause_reload = 0

@export var submenus : Array[Control]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if pause_reload > 0:
		pause_reload -= delta

func _input(event: InputEvent) -> void:
	if event.is_echo(): return
	if (event is not InputEventMouse):
		if event.is_action_pressed("pause") and pause_reload <= 0:
			toggle_pause()
			pause_reload = 0.1

# toggle the pause
func toggle_pause():
	# grab current state
	var currState = get_tree().paused
	
	if (currState == false):
		# currently pausing
		show()
		load_submenu(0)
	else:
		# currently resuming
		hide()
	
	# flip state
	get_tree().paused = !currState

#region pause submenu handling

# iterate through each submenu, hide all except intended submenu
func load_submenu(show_index : int):
	for menu_indx in submenus.size():
		if (menu_indx != show_index):
			submenus[menu_indx].hide()

#endregion
