extends Node
class_name VelocityComponent

@export var speed: float = 400.0
@export var flip_sprite: bool = true
@export var sprite: AnimatedSprite2D

var target: Node2D = null

func _process(delta: float) -> void:
	if target:
		var direction = (target.global_position - get_parent().global_position).normalized()
		get_parent().position += direction * speed * delta
		
		if flip_sprite and sprite:
			var target_scale = 1.0 if direction.x > 0 else -1.0
			sprite.scale.x = lerp(sprite.scale.x, target_scale, 0.2 * delta * 60)  
