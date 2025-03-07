extends Area2D



func _ready() -> void:
	$ani_moneda.play()
	
#Logica cuando un jugador recoge moneda
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.add_monedas()
		print("moneda recogida")
		queue_free()
