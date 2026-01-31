extends Control

# grab the child animation player
@onready var transitionPlayer = $AnimationPlayer

var fadingOut = false
var busVol = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	SignalBus.fade_to_level.connect(fadeToScene)

func _process(delta : float) -> void:
	if (fadingOut):
		busVol = max(busVol-delta*5, 0)
		AudioServer.set_bus_volume_linear(0, busVol)
	elif (busVol < 1):
		busVol = min(busVol+delta*5, 1)
		AudioServer.set_bus_volume_linear(0, busVol)

# fade to scene
func fadeToScene(scene : String):
	if (scene.is_empty() or !ResourceLoader.exists(scene)):
		print("ERROR, scene not found")
		return
	fadeOut()
	await transitionPlayer.animation_finished
	get_tree().change_scene_to_file(scene)

func fadeOut():
	transitionPlayer.play("FadeOut")
	fadingOut = true

func fadeIn():
	transitionPlayer.play("FadeOut")
