extends MeleeEnemy


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter:
		body.health = body.health - 1
	print(body)
