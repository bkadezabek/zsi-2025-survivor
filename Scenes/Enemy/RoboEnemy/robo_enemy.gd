extends Enemy

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready() -> void:
	health_component = $HealthComponent
	velocity_component = $VelocityComponent
	setup_shooting()
	super._ready()
	
	animated_sprite_2d.play("run")

func _on_health_component_death():
	animated_sprite_2d.play("death")
	velocity_component.speed = 0
	await animated_sprite_2d.animation_finished 
	queue_free()
