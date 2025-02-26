extends Area2D

var speed: float = 450.0
var direction: Vector2 = Vector2.ZERO

var damage: int = 0

func _ready():
	rotation = direction.angle()

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		return
	
	if body.is_in_group("ENEMY") and body.has_method("take_damage"):
		body.take_damage(damage)
	
	queue_free()
