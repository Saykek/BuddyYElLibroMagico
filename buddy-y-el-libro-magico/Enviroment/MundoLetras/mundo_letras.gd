
extends Node2D

# Variable para almacenar las letras recogidas
var letras_recogidas = []


var jugador =$Player

func _ready():

	crear_letras()

	for letra in get_children():
		if letra.is_in_group("letra"):
			letra.connect("area_entered", self, "_on_letra_recogida")

# Crear las letras y ubicarlas en el escenario
func crear_letras():
	var posiciones = [
		Vector2(100, 100),
		Vector2(300, 100),
		Vector2(500, 100),
		Vector2(700, 100),
		Vector2(900, 100)
	]

	var letras = ["A", "B", "C", "D", "E"]

	for i in range(letras.size()):
		var area = Area2D.new()
		area.name = "letra_" + letras[i]
		area.position = posiciones[i]
		area.add_to_group("letra")
		

		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = RectangleShape2D.new()
		area.add_child(collision_shape)
		

		var label = Label.new()
		label.text = letras[i]
		area.add_child(label)
		
		add_child(area)

func _on_letra_recogida(area: Area2D):
	if area.is_in_group("letra"):

		FuncionesCompartidas.agregar_letra(area.name.split("_")[1])  # Usamos el nombre del área como letra
		area.queue_free() 
