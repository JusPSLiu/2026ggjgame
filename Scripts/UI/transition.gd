extends Control

# grab the child animation player
@onready var transitionPlayer = $AnimationPlayer

var busVol = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	SignalBus.fade_to_level.connect(fadeToScene)

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

func fadeIn():
	transitionPlayer.play("FadeOut")
