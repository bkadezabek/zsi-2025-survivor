extends Gun

@export var spread_angle: float = 20.0
@export var num_projectiles: int = 8
@export var projectile_damage: int = 5
@onready var muzzle = $Muzzle

func shoot() -> void:
	for i in range(num_projectiles):
		var angle_offset = randf_range(-spread_angle, spread_angle)
		var direction = (get_global_mouse_position() - muzzle.global_position).normalized().rotated(deg_to_rad(angle_offset))
		
		var projectile = projectile_scene.instantiate()
		projectile.global_position = muzzle.global_position
		projectile.damage = projectile_damage
		projectile.direction = direction
		get_tree().root.add_child(projectile)
