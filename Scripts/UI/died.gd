extends Control


func _ready():
	hide()
	SignalBus.died.connect(show)
