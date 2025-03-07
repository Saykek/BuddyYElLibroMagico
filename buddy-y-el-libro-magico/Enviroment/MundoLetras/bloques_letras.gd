extends Node2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.add_letra()
		print("letra recogida")
		queue_free()
