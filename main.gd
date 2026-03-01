extends Node2D

@export var plyr : PlayerCharacter
@export var cat : FollowingEntity


func _on_tile_map_layer_cave_gen_done() -> void:
	plyr.global_position = $TileMapLayer.spawnPosition * $TileMapLayer.scale
	plyr.global_position += Vector2(100,0)
	cat.global_position = plyr.global_position

var queuedUp = false
func _process(delta: float) -> void:
	if Ui.isDeadOrWin:
		if !queuedUp:
			queuedUp = true
			$TileMapLayer.slowlyRemoveTiles()
