extends Area2D  # Este script extiende Area2D

# Referencias a los contenedores donde se encuentran los Label
var contenedor_letras
var jugador_body

# Array de las letras que el jugador debe recoger
var letras_recogidas = []

# Inicialización
func _ready():
	# Obtener referencia al jugador
	jugador_body = get_node("/root/escena_principal/Jugador")

	# Obtener referencia a los Labels (usamos una forma más dinámica para acceder a los Labels)
	for i in range(5):  # Asumiendo que tienes 5 labels
		var lbl = get_node("/root/escena_principal/ContenedorLetras/lbl_" + str(i + 1))
		# Aquí guardamos las referencias a los labels en una lista para poder usarlos más tarde
		lbl.text = ""  # Iniciar vacío
		letras_recogidas.append(lbl)  # Guardar las referencias de los labels

	# Crear el Area2D para cada botón (esto se haría para cada letra que el jugador pueda recoger)
	for letra in ["L", "I", "B", "R", "O"]:
		crear_area_boton(letra)

# Crear un Area2D para cada botón en el TileMap (por cada letra)
func crear_area_boton(letra: String):
	var area_boton = Area2D.new()
	area_boton.name = "Boton_" + letra
	add_child(area_boton)

	# Crear el CollisionShape2D
	var colision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(16, 16)  # Ajusta el tamaño de la colisión
	colision.shape = shape
	area_boton.add_child(colision)

	# Posicionar el Area2D
	area_boton.position = get_posicion_boton(letra)  # Ajusta las posiciones


# Función que obtiene la posición de cada botón en el mapa
func get_posicion_boton(letra: String) -> Vector2:
	# Establecer las posiciones de los botones de forma manual o de acuerdo a tu mapa
	if letra == "L":
		return Vector2(0, 0)
	elif letra == "I":
		return Vector2(1, 0)
	elif letra == "B":
		return Vector2(2, 0)
	elif letra == "R":
		return Vector2(3, 0)
	elif letra == "O":
		return Vector2(4, 0)
	return Vector2.ZERO  # Default

# Detecta cuando el jugador entra en el área de una letra
func _on_body_entered(body, letra: String):  # Agregamos 'letra' como argumento
	if body == jugador_body:  # Si el cuerpo que entra es el jugador
		# Añadir la letra al array de letras recogidas
		if letras_recogidas.size() < 5:
			letras_recogidas.append(letra)

			# Actualizar los Labels con la letra recogida
			for i in range(len(letras_recogidas)):
				var lbl = get_node("/root/escena_principal/ContenedorLetras/lbl_" + str(i + 1))
				lbl.text = letras_recogidas[i]
			
			# Eliminar el área después de ser recogida
			body.queue_free()
