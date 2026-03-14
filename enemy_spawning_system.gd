extends Node

@export var spawnRates = 0.0

var enemies = [preload("res://BabyZombie.tscn"),preload("res://zombie.tscn")]

func _process(delta: float) -> void:
	if randf() < spawnRates:
		var angle = randf_range(0,2 * PI)
		var dist = randf_range(162.955 * 2,162.955 * 3)
		var offset = Vector2(cos(angle),sin(angle)) * dist
		var finalPosition = $"../Player".global_position + offset
		
		var tilePos = $"../TileMapLayer".local_to_map($"../TileMapLayer".to_local(finalPosition))
		if $"../TileMapLayer".get_cell_source_id(tilePos) == 0:
			if $"../TileMapLayer".get_cell_atlas_coords(tilePos) == Vector2i.ONE:
				var NewEnemy = enemies.pick_random().instantiate()
				get_parent().add_child(NewEnemy)
				NewEnemy.global_position = finalPosition
			
		
