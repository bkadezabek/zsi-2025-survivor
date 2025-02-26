extends Gun

@onready var muzzle = $Muzzle

func shoot() -> void:
	var projectile = projectile_scene.instantiate()
	projectile.global_position = muzzle.global_position
	projectile.direction = (get_global_mouse_position() - muzzle.global_position).normalized()
	get_tree().root.add_child(projectile)
