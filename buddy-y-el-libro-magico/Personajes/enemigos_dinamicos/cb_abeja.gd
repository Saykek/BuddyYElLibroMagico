extends CharacterBody2D

const VELOCIDAD = 100.0
var direccion = 1
var velocidad_movimiento = Vector2.ZERO  # Inicializamos la velocidad como Vector2.ZERO

@onready var ani_abeja = $ani_abeja

func _ready():
	# Establecemos la velocidad inicial del movimiento
	velocidad_movimiento = Vector2(0,VELOCIDAD * direccion)
	ani_abeja.play("ataque")
	

func _process(delta):
	# Actualizamos la velocidad en función de la dirección
	velocidad_movimiento.y = VELOCIDAD * direccion
	
	velocity = velocidad_movimiento
	
	move_and_slide()
	
	 
	# Cambiar la dirección al llegar a un límite
	if position.y > 320:  
		direccion = -1 
		
	elif position.y < 14:  
		direccion = 1  
		
		
	
func _on_area_abeja_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.perder_vida(position.x)
