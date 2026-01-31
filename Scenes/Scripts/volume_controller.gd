extends Control


@onready var musicslider : HSlider = $VBoxContainer/MusicSlider
@onready var soundslider : HSlider = $VBoxContainer/SoundSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set the values under AUDIO
	musicslider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(1)))
	soundslider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(2)))


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_sound_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
