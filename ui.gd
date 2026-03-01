extends CanvasLayer
class_name uiHolderNode

var playerObjects : Array[PlayerCharacter] = []
var catObjects : Array[FollowingEntity] = []

var isDeadOrWin = false;

func resetVisuals():
	$DeathScreen.visible = false
	$WinScreen.visible = false
	playerObjects.clear()
	catObjects.clear()

func _process(delta: float) -> void:
	var died = false
	var won = false
	for plyr in playerObjects:
		if plyr:
			if plyr.health <= 0:
				died = true
	for cat in catObjects:
		if cat:
			if cat.health <= 0:
				died = true
	
	for cat in catObjects:
		if cat:
			if cat.global_position.y < -10:
				won = true
			
	
	
	if died:
		$DeathScreen.visible = true
		isDeadOrWin = true
	if won:
		$WinScreen.visible = true
		isDeadOrWin = true

func set_depth(de):
	$depth.text = "DEPTH: " + str(de)

func showBlocksRem(current,total):
	$BlocksRem.text = "Blocks Remaining: " + str(current) + " / " + str(total)

func showResetBlockProgress(num):
	$ResetBlocks.visible = true
	$ResetBlocks.value = num

func hideResetBlockProgress():
	$ResetBlocks.visible = false
