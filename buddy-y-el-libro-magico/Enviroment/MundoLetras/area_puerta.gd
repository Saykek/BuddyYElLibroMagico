extends Area2D


@onready var puerta = $col_puerta

#Detectar la colision

func cuerpo_entra_puerta(body):
	if body.is_in_group("jugador"):
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Enviroment/MundoLetras/puzzle_letras.tscn")
