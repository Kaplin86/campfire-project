extends Node

@export var tilemap : TileMapLayer 

@export var BlockCount = 10
var blocksUsedSoFar = 0

func _process(delta: float) -> void:
	if Input.is_action_pressed("placeblock") and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if blocksUsedSoFar < BlockCount:
			var tilePos = tilemap.local_to_map(get_viewport().get_mouse_position())
			tilemap.set_cell(tilePos,-1)
