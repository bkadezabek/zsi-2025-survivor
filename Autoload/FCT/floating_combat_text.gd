extends Node2D

@onready var label = $Label

@export var lifetime: float = 1.0
@export var float_distance: float = 30.0
@export var position_variance: float = 15.0
@export var angle_variance: float = 30.0

func setup(number: int, start_position: Vector2):
	position = start_position + Vector2(
		randf_range(-position_variance, position_variance), 
		randf_range(-position_variance, position_variance)
	)
	label.text = str(number)
	
	var angle_offset = deg_to_rad(randf_range(-angle_variance, angle_variance))
	var direction = Vector2(0, -1).rotated(angle_offset) * float_distance
	
	var tween = create_tween()
	tween.tween_property(self, "position", position + direction, lifetime) \
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(label, "modulate:a", 0, lifetime)
	tween.tween_callback(queue_free)
