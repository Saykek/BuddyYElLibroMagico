extends CharacterBody2D

const VELOCIDAD = 100.0
const JUMP_VELOCITY = -200.0
var direccion = 1
var velocidad_movimiento = Vector2.ZERO  # Inicializamos la velocidad como Vector2.ZERO
var detectando_player = false
@onready var ani_camaleon = $ani_camaleon
@onready var rayo = $detector_derecho
@onready var rayo_abajo =$detector_derechoAbajo

func _ready():
	ani_camaleon.play("idle")
	
func _process(delta: float) -> void:
	if rayo.is_colliding():
		print("entrando en if rayo")
		var colision=rayo.get_collider() #si el rayo detecta algo
		if colision.is_in_group("jugador"):
				
			if not detectando_player:
				print("entrando en if not")
				detectando_player = true
				ani_camaleon.play("run")
				direccion=1
				velocidad_movimiento.x = VELOCIDAD * direccion
	
	if detectando_player:
		ani_camaleon.play("attack")
		
		# Verificar si no hay suelo debajo del personaje usando el rayo_abajo
	if not rayo_abajo.is_colliding():
		velocidad_movimiento.x = 0  
		direccion = -direccion
		ani_camaleon.flip_h = !ani_camaleon.flip_h  
		velocidad_movimiento.x = VELOCIDAD * direccion

	velocity = velocidad_movimiento
	move_and_slide()  
	


func _on_area_camaleon_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.perder_vida(position.x)
