extends Node2D



func _on_area_pinchos_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.perder_vida(position.x)
