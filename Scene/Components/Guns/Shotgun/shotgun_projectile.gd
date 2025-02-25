extends Area2D

var speed: float = 400.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	rotation = direction.angle()

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("PLAYER"):
		return
	queue_free()
