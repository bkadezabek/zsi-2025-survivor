extends Node
class_name VelocityComponent

@export var speed: float = 400.0
@export var flip_sprite: bool = true
@export var sprite: AnimatedSprite2D

var target: Node2D = null

# 4. Dan ---
func _ready() -> void:
	# Connect to PlayerManager signals
	PlayerManager.player_spawned.connect(_on_player_spawned)
	PlayerManager.player_freed.connect(_on_player_freed)
	
	# Set initial target if the player already exists
	if PlayerManager.player:
		_on_player_spawned(PlayerManager.player)

func _on_player_spawned(player: Node2D) -> void:
	target = player

func _on_player_freed() -> void:
	target = null
# ----------

func _process(delta: float) -> void:
	if target:
		var direction = (target.global_position - get_parent().global_position).normalized()
		get_parent().position += direction * speed * delta
		
		if flip_sprite and sprite:
			var target_scale = 1.0 if direction.x > 0 else -1.0
			sprite.scale.x = lerp(sprite.scale.x, target_scale, 0.2 * delta * 60)  
