extends TileMapLayer

var heightsOfSegment = {}
var spawnPosition = null
var highestYShare = 0

signal caveGenDone

func indexSegments():
	pass

func slowlyRemoveTiles():
	for I in get_used_cells():
		await get_tree().create_timer(0.01).timeout
		set_cell(I,-1)

func _ready() -> void:
	
	#kkkkkkkkkaplin!!!!!!!!11
	_generate_cave(500,900)
	
	
	

func _generate_cave(cavewidth,caveheight):
	var patternCount = tile_set.get_patterns_count()
	for w in cavewidth:
		for h in caveheight:
			set_cell(Vector2i(w,h),0,Vector2i.ZERO)
	
	var Ylevel = caveheight - 90
	var Xpos = floor(cavewidth / 2)
	set_pattern(Vector2i(Xpos,Ylevel),tile_set.get_pattern(0))
	spawnPosition = map_to_local(Vector2i(Xpos,Ylevel))
	for I in caveheight / 3:
		var pickedPattern = randi_range(0,patternCount - 1)
		var pickedPatternObject = tile_set.get_pattern(pickedPattern)
		set_pattern(Vector2i(Xpos,Ylevel),pickedPatternObject)
		Ylevel -= 2
		Xpos += (1 - (randf() * 2)) * 20
		Xpos = clamp(Xpos,cavewidth * 0.1,cavewidth * 0.9)
	
	var highestY = 999
	
	for Pos in get_used_cells_by_id(0,Vector2.ONE):
		set_cell(Pos,-1)
		if Pos.y < highestY:
			highestY = Pos.y
	
	highestY += 2
	highestYShare = highestY
	
	for I in 50:
		for X in cavewidth:
			set_cell(Vector2(X,highestY - I),-1)
	
	caveGenDone.emit()
	





func _on_h_slider_value_changed(value: float) -> void:
	print("BAA")
	_generate_cave(500,300)
