extends AudioStreamPlayer2D

@export var range : Vector2 = Vector2(0.8, 1.1)

func play_sound(vol : float = 1.0):
	volume_linear = vol
	pitch_scale = randf_range(range.x, range.y)
	play()
