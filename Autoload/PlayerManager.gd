# player_manager.gd
extends Node

signal player_spawned(player: Node2D)
signal player_freed()

var player: Node2D = null

func set_player(new_player: Node2D) -> void:
	if player and is_instance_valid(player):
		player.disconnect("tree_exited", _on_player_freed)
	
	player = new_player
	
	if player:
		player.connect("tree_exited", _on_player_freed)
		player_spawned.emit(player)
	else:
		player_freed.emit()

func _on_player_freed() -> void:
	player = null
	player_freed.emit()

