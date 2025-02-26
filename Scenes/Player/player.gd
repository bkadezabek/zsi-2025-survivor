extends CharacterBody2D

@onready var camera: Camera2D = $Camera2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var health_component: HealthComponent = $HealthComponent

@export var camera_offset_factor: float = 0.6
@export var max_camera_offset: float = 33.0

var speed: float = 200.0

func _ready() -> void: 
	PlayerManager.set_player(self)

func _process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		direction.y -= 1
	if Input.is_action_pressed("Down"):
		direction.y += 1
	if Input.is_action_pressed("Left"):
		direction.x -= 1
	if Input.is_action_pressed("Right"):
		direction.x += 1
	
	velocity = direction.normalized() * speed
	move_and_slide()
	
	if direction.length() > 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	offset_camera_on_mouse_position()
	flip_sprite_on_mouse_position(get_global_mouse_position())

func offset_camera_on_mouse_position() -> void:
	var mouse_position = get_global_mouse_position()
	var to_mouse = mouse_position - global_position
	var desired_offset = to_mouse * camera_offset_factor
	
	if desired_offset.length() > max_camera_offset:
		desired_offset = desired_offset.normalized() * max_camera_offset
	
	camera.position = desired_offset
	
func flip_sprite_on_mouse_position(mouse_position: Vector2) -> void:
	var character_position = global_position
	if mouse_position.x < character_position.x:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false


# 4. Dan
func _on_health_component_death():
	print("Player has died!")
	queue_free()

func take_damage(amount: int) -> void:
	health_component.take_damage(amount)
