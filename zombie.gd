extends MeleeEnemy
@export var offset = 24
var bindedPlayer : PlayerCharacter = null
@export var movementSpeed = 6000
func _on_vision_body_entered(body: Node2D) -> void:
	
	if body is PlayerCharacter:
		bindedPlayer = body
		

func _process(delta):
	
	if bindedPlayer != null:
		var directionToPlayer = bindedPlayer.global_position - global_position
		velocity.x = (directionToPlayer.normalized() * movementSpeed * delta).x
		
	
	$TextureProgressBar.value = health
	$TextureProgressBar.max_value = maxhp
	if health <= 0:
		queue_free()
	if velocity.x != 0:
		if velocity.x <0:
			$Area2D.position.x = -offset
		else:
			$Area2D.position.x = offset
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter or body is FollowingEntity:
		body.health = body.health - 1
	
		$Area2D.set_deferred('monitoring',false)
		await get_tree().create_timer(2).timeout
		$Area2D.set_deferred('monitoring',true)
		
		
		
	print(body)
