extends Node

var fct: PackedScene = preload("res://Autoload/FCT/floating_combat_text.tscn")

func create_fct(number: int, position: Vector2):
	if not fct:
		push_error("Fali floating_text scena :(")
		return
	
	var fct_instance = fct.instantiate()
	get_tree().root.add_child(fct_instance)
	fct_instance.setup(number, position)
