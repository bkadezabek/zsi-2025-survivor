extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var speed: float = 550.0
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	animated_sprite_2d.play("rocket")
	rotation = direction.angle()

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("PLAYER"):
		return
	queue_free()
