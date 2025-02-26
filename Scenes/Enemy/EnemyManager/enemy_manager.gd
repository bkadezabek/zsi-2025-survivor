# EnemyManager.gd
extends Node

@export var enemy_scenes: Array[PackedScene]
@export var spawn_curve: Curve
@export var initial_spawn_delay: float = 5.0 
@export var max_spawn_rate: float = 0.5
@export var spawn_area: Rect2 

@onready var spawn_timer = $SpawnTimer

var time_elapsed: float = 0.0

func _ready() -> void:
	print("Ready")
	spawn_timer.wait_time = initial_spawn_delay
	spawn_timer.start()

func _process(delta: float) -> void:
	time_elapsed += delta

func spawn_enemy() -> void:
	print("Spawnam")
	if enemy_scenes.is_empty():
		return
	
	var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	var enemy = enemy_scene.instantiate()
	
	var spawn_position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.end.x),
		randf_range(spawn_area.position.y, spawn_area.end.y)
	)
	enemy.position = spawn_position
	
	add_child(enemy)
	
	# Nakon 60 sekundi postignemo 1 odnosno spawn/5.0s
	var curve_value = spawn_curve.sample(time_elapsed / 60.0)
	spawn_timer.wait_time = lerp(initial_spawn_delay, max_spawn_rate, curve_value)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	print("Spawn")
	spawn_enemy()

