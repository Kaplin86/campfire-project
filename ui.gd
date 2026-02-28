extends CanvasLayer
class_name uiHolderNode

var playerObjects : Array[PlayerCharacter] = []
var catObjects : Array[FollowingEntity] = []

func _process(delta: float) -> void:
	var died = false
	for plyr in playerObjects:
		if plyr.health <= 0:
			died = true
	for cat in catObjects:
		if cat.health <= 0:
			died = true
	
	if died:
		$DeathScreen.visible = true
