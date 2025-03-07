extends Control

func actualizar(monedas:int):
	$"HBoxContador/lbl_contador".text = str(monedas)
	
func actualizarLetra(letra:int):
	$HBoxLetras/lbl_letras.text = str(letra)

func actualizar_vida(vida:int):
	$HBoxVida/lbl_vida.text = str(vida)
