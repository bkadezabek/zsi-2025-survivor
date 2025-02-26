extends Node2D
class_name Enemy

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent

@export var projectile_scene: PackedScene
@export var min_shoot_interval: float = 3.0
@export var max_shoot_interval: float = 10.0

# Enemy.gd
# 4. Dan - Obavezno staviti 'var player' ovdje, a 'player' samo u _ready)()
var player: Node2D = null
var shoot_timer: Timer = null 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER")
	if player:
		velocity_component.target = player

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)


# 4. Dan ---- Enemy.gd
func setup_shooting() -> void:
	print("Setup pucanje")
	# Create a new Timer node
	shoot_timer = Timer.new()
	shoot_timer.name = "ShootTimer"
	shoot_timer.one_shot = false  # Make the timer repeat
	add_child(shoot_timer)
	
	# Connect the timer's timeout signal to the shoot function
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	
	# Start shooting
	start_shooting()

func start_shooting() -> void:
	print("pocinjem pucat")
	# Set a random initial delay before the first shot
	shoot_timer.wait_time = randf_range(min_shoot_interval, max_shoot_interval)
	shoot_timer.start()

func shoot() -> void:
	print("Pucam")
	if not player or not projectile_scene:
		return
	
	# Calculate the direction to the player
	var direction = (player.global_position - global_position).normalized()
	
	# Spawn the projectile
	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.direction = direction
	get_tree().root.add_child(projectile)
	
	# Set a new random wait time for the next shot
	shoot_timer.wait_time = randf_range(min_shoot_interval, max_shoot_interval)
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	shoot()

# -------------
