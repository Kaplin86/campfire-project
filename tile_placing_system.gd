extends Node

@export var tilemap : TileMapLayer 

@export var BlockCount = 20
@export var buildingTileAtlasCords : Vector2i = Vector2i(1,0)
@export var resetTime = 3
var blocksUsedSoFar = 0
var holdTime = 0

func _ready() -> void:
	Ui.showBlocksRem(BlockCount - blocksUsedSoFar,BlockCount)


func _process(delta: float) -> void:
	
	if Input.is_action_pressed("placeblock"):
		print("attempting to place")
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			print("is pressing button")
			if blocksUsedSoFar < BlockCount:
				var mouseToMap = get_viewport().get_camera_2d().get_global_mouse_position()
				var tilePos = tilemap.local_to_map(tilemap.to_local(mouseToMap))
				
				if tilemap.get_cell_atlas_coords(tilePos) != Vector2i(1,0):
					if tilemap.get_cell_source_id(tilePos) == -1:
						tilemap.set_cell(tilePos,0,Vector2i(1,0))
						blocksUsedSoFar += 1
						Ui.showBlocksRem(BlockCount - blocksUsedSoFar,BlockCount)
				print(mouseToMap)
				holdTime = 0
		if blocksUsedSoFar >= BlockCount:
			holdTime += delta
			var progresspercent = holdTime / resetTime
			print("percent is", progresspercent, " and holdtime is ", holdTime)
			Ui.showResetBlockProgress((progresspercent) * 100)
			
			if progresspercent >= 1:
				for cell in tilemap.get_used_cells_by_id(0,buildingTileAtlasCords):
					tilemap.set_cell(cell,-1)
				blocksUsedSoFar = 0
				Ui.showBlocksRem(BlockCount - blocksUsedSoFar,BlockCount)
			
		else:
			Ui.hideResetBlockProgress()
	
	else:
		holdTime = 0
		Ui.hideResetBlockProgress()
