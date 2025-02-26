extends Node
class_name HealthComponent

signal death

@export var max_health: int = 20
var current_health: int

func _ready():
	current_health = max_health

func take_damage(amount: float) -> void:
	current_health -= amount
	FCT.create_fct(amount, get_parent().global_position)
	if current_health <= 0:
		die()

func die() -> void:
	print("Ded:(")
	death.emit()
