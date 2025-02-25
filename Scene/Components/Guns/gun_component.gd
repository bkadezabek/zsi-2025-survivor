extends Node2D

@onready var gun_node = $Gun

func _ready() -> void:
	switch_gun(preload("res://Scene/Components/Guns/Shotgun/shotgun.tscn"))

func _process(delta) -> void:
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	var angle = direction.angle()
	rotation = angle
	
	if direction.x < 0:
		scale.y = -1
	else:
		scale.y = 1
	
	
	if Input.is_action_just_pressed("Shoot"):
		if gun_node.get_child_count() > 0:
			var current_gun = gun_node.get_child(0)
			current_gun.shoot()
			
func switch_gun(new_gun: PackedScene) -> void:
	if gun_node.get_child_count() > 0:
		gun_node.get_child(0).queue_free()
	
	var new_gun_instance = new_gun.instantiate()
	gun_node.add_child(new_gun_instance)
