# enemy_projectile.gd
extends Area2D

@export var speed: float = 400.0  # Movement speed
@export var damage: float = 10.0  # Damage dealt by the projectile

var direction: Vector2 = Vector2.ZERO  # Direction of movement

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Move the projectile
	position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	# Check if the body is in the PLAYER group and has a take_damage method
	if body.is_in_group("PLAYER"):
		print("PLAYER")
		body.take_damage(damage)
	
	# Destroy the projectile on collision
	queue_free()
	
# PAZI DA POSTAVIMO COLLISION LAYER: 3 Layer, 1 Mask
# OOOOBAVEZNO SPOJITI _on_body_entered u ovoj skripti!!!

