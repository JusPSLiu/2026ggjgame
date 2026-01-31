extends Node2D

@export_storage var length = 0
var offset : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2.ONE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	# TODO: queue free
