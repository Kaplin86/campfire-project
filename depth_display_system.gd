extends Node

func _process(delta: float) -> void:
	var caveHeight = $"../TileMapLayer".highestYShare
	var heightpixel = $"../TileMapLayer".map_to_local(Vector2i(0,caveHeight))
	var dist = 0 - $"../Player".global_position.y 
	Ui.set_depth(dist)
