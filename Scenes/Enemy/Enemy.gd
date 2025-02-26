extends Node
class_name Enemy

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("PLAYER")
	if player:
		velocity_component.target = player

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)
