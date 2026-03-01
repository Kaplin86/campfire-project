extends MeleeEnemy
@export var offset = 24
var bindedPlayer : PlayerCharacter = null
@export var movementSpeed = 6000
var punchAnimDuration = 9

func _on_vision_body_entered(body: Node2D) -> void:
	
	if body is PlayerCharacter:
		bindedPlayer = body
		

func _process(delta):
	punchAnimDuration += delta
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
		
	if punchAnimDuration < 0.3:
		$AnimatedSprite2D.animation = "punch"
	else:
	
		if abs(velocity.x) <= 0.2:
			$AnimatedSprite2D.animation = "default"
		else:
			$AnimatedSprite2D.animation = "walk"
			print("vis change")
			if velocity.x<0:
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.flip_h = true
		
		if not abs(velocity.y) <= 0.2:
			if velocity.y<0:
				$AnimatedSprite2D.animation = "air"
			else:
				$AnimatedSprite2D.animation = "fall"
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter or body is FollowingEntity:
		body.health = body.health - 1
	
		punchAnimDuration = 0
	
		$Area2D.set_deferred('monitoring',false)
		await get_tree().create_timer(2).timeout
		$Area2D.set_deferred('monitoring',true)
		
		
		
	print(body)
