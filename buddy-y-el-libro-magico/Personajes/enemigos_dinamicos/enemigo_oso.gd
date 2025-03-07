extends CharacterBody2D


const VELOCIDAD = 100.0
var direccion = 1
var velocidad_movimiento = Vector2.ZERO  # Inicializamos la velocidad como Vector2.ZERO
@onready var oso = $"."

func _ready():
	# Establecemos la velocidad inicial del movimiento
	velocidad_movimiento = Vector2(VELOCIDAD * direccion, 0)

func _process(delta):
	# Actualizamos la velocidad en función de la dirección
	velocidad_movimiento.x = VELOCIDAD * direccion
	
	velocity = velocidad_movimiento
	
	move_and_slide()
	 
	# Cambiar la dirección al llegar a un límite
	if position.x > 220:  # Ajusta el límite según el tamaño de tu mapa
		direccion = -1  # Cambiar dirección a la izquierda
		print(position.x)
	elif position.x < -150:  # Ajusta el límite de vuelta
		direccion = 1  # Cambiar dirección a la derecha
		print(position.x) 


func _on_area_oso_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.perder_vida(position.x)
