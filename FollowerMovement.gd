extends CharacterBody2D
class_name FollowingEntity

@export var health = 5
@export var maxHealth = 5

var bindedPlayer : PlayerCharacter = null
var movementSpeed = 6000
var gravityStacks = Vector2(0,0)
var JUMP_VELOCITY = -900.0

@onready var healthBar = $TextureProgressBar


func _physics_process(delta: float) -> void:
	
	healthBar.max_value = maxHealth
	healthBar.value = health
	
	if bindedPlayer != null:
		var directionToPlayer = bindedPlayer.global_position - global_position
		velocity.x = (directionToPlayer.normalized() * movementSpeed * delta).x
		 
		
	
	# the gravite
	if is_on_floor():
		velocity.y = 0
		
		if bindedPlayer != null:
			var directionToPlayer = bindedPlayer.global_position - global_position
			if directionToPlayer.y < -1:
				velocity.y = JUMP_VELOCITY
		
	else:
		velocity.y += get_gravity().y * delta
	

	
	move_and_slide()


func _on_vision_body_entered(body: Node2D) -> void:
	
	if body is PlayerCharacter:
		bindedPlayer = body
