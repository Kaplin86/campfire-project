extends MeleeEnemy


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter or body is FollowingEntity:
		body.health = body.health - 1
	
		$Area2D.set_deferred('monitoring',false)
		await get_tree().create_timer(2).timeout
		$Area2D.set_deferred('monitoring',true)
		
	print(body)
