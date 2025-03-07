extends Node

var vida = 3
var monedas = 0

func _ready():
	pass

# Método para agregar monedas
func add_monedas():
	monedas += 1

# Método para perder una vida
func perder_vida():
	vida -= 1
