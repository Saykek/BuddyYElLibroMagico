extends Node

# Array para almacenar las letras recogidas
var letras_recogidas = []

# Función para agregar una letra
func agregar_letra(letra: String):
	letras_recogidas.append(letra)

# Función para obtener las letras recogidas
func obtener_letras() -> Array:
	return letras_recogidas
	
