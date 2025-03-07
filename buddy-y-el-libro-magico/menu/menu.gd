extends Control


func _on_btn_empezar_pressed():
	get_tree().change_scene_to_file("res://Enviroment/MundoLetras/MundoLetras.tscn")


func _on_btn_salir_pressed():
	get_tree().quit()
