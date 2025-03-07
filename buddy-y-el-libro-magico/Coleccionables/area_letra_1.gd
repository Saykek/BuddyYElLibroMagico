extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.add_letras()
		print("letra recogida")
		queue_free()
