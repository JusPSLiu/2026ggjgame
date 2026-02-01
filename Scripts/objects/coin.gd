extends Node2D

var collected = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player") and !collected):
		collected = true
		GlobalVariables.money += 1
		print_debug("MONEY: ", GlobalVariables.money)
		$Collected.play("collected")
