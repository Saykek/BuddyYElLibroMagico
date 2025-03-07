extends CharacterBody2D


@export var gravity_scale = 2
@export var speed = 400
@export var acceleration = 200
@export var friction = 1200
@export var jump_force = -900
@export var air_acceleration = 1000
@export var air_friction = 900
@export var vida = 3
@export var jugador_muerto = false
@export var monedas: int = 0
@export var letra = 0
@export var movimiento = Vector2.ZERO


@onready var audio_letra = $audios/audio_letra
@onready var audio_moneda = $audios/audio_moneda
@onready var audio_agua =$"../audio_agua"
@onready var tiempo_agua = $tiempo_agua
@onready var tiempo = $Tiempo
@onready var sonido_muerte = $audios/muerte
@onready var sonido_fin_vidas = $audios/fin_vidas
@onready var sonido_salto =$audios/salto
@onready var ani_player =$ani_player  # referenciamos el objeto
@onready var musica =$"../AudioStreamPlayer2D"
@onready var contador : Control =$"CanvasLayer/interfaz_player"
	


func _ready():
	contador.actualizar_vida(vida)
	contador.actualizar(monedas)
	contador.actualizarLetra(letra)
func add_monedas():
	monedas +=1
	contador.actualizar(monedas)
	audio_moneda.play()
	print ("MONEDA SUMADA")	
func add_letras():
	letra +=1
	contador.actualizarLetra(letra)
	audio_letra.play()
	print ("LIBRO SUMADo")
func caida_vacio():
	if vida>0:	
		vida -=1
		audio_agua.play()
		print(vida)
		tiempo_agua.start()
		contador.actualizar_vida(vida)
		await tiempo_agua.timeout
		get_tree().reload_current_scene()
	else:	
		ani_player.play("morir")
		sonido_fin_vidas.play()
		tiempo.start()
		await tiempo.timeout
		get_tree().reload_current_scene() 
		

# RECIBIR DAÑO
func perder_vida(enemigo_posicion: float):
	# para rebotar contra el enemigo
	if position.x < enemigo_posicion:
		velocity.x=-400
		velocity.y=-200
		
	velocity.x=400
	velocity.y=-200

	if vida>0:	
		vida -=1
		sonido_muerte.play()
		contador.actualizar_vida(vida)
		print(vida)
	else:	
		ani_player.play("morir")
		sonido_fin_vidas.play()
		tiempo.start()
		await tiempo.timeout
		get_tree().change_scene_to_file("res://Enviroment/MundoLetras/game_over.tscn")		
# REFERENCIAMOS LOS MOVIMIENTOS CON LOS SPRITES
func update_animation(input_axis):
	if input_axis !=0:
		# velocidad de la animación será dependiente de la velocidad
		ani_player.speed_scale = velocity.length()/100
		ani_player.flip_h = (input_axis<0)
		ani_player.play("walk")
	elif not is_on_floor():
		ani_player.play("jump")
	else:
		ani_player.speed_scale=1
		ani_player.play("idle")
func apply_gravity(delta):
	if not is_on_floor():
		velocity+=get_gravity() * delta * gravity_scale
	# MOVIMIENTO LATERAL
func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0: #recoge valores para mover izq y dcha
		velocity.x = move_toward(velocity.x, speed*input_axis, acceleration*delta)
	# MOVIMIENTO EN PARADO, ES DECIR, 0		
func apply_friction(input_axis, delta):
	if input_axis==0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction*delta)	

	# SALTO		
func handle_jump():
	if is_on_floor():
		if Input.is_action_pressed("saltar"):
			velocity.y = jump_force
			sonido_salto.play()
			
	# PELEAR
func pelea():
	if is_on_floor():
		if Input.is_action_pressed("pelea"):
			ani_player.play("Attack")
	else:
		if Input.is_action_pressed("pelea"):
			ani_player.play("jumpAttack")
		
	# MOVIENTO EN EL AIRE		
func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, speed*input_axis, air_acceleration *delta)
func _physics_process(delta: float) -> void:
	var input_axis = Input.get_axis("izquierda","derecha")
	
	apply_gravity(delta)
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	handle_jump()
	handle_air_acceleration(input_axis, delta)
	update_animation(input_axis)
	pelea()
	move_and_slide()		# Aplica los cambios en ejecución
	
	#estaColisionando()
