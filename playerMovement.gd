extends CharacterBody2D
class_name PlayerCharacter

var health = 10
var fallDamage = 550 #When you fall at a velocity of 650 pixels you take 1 damage


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var inAirLastFrame = false
var lastAirVelocity = Vector2.ZERO

func hui():
	pass

func _ready() -> void:
	# adds it self to the ui's player objects
	Ui.playerObjects.append(self)
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	$TextureProgressBar.value = health
	if velocity.x != 0:
		if velocity.x <0:
			$Area2D.position.x = -90.0
		else:
			$Area2D.position.x = -62.0
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		inAirLastFrame = true
		lastAirVelocity = velocity
	
	if is_on_floor() and inAirLastFrame:
		inAirLastFrame = false
		var damageToTake = floor(lastAirVelocity.y / fallDamage)
		print(lastAirVelocity.y)
		health = health - damageToTake
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	$Area2D.visible = $Area2D.monitoring
	if Input.is_action_just_pressed("attack"):
		
		for enemy in $Area2D.get_overlapping_bodies():
			
			_on_area_2d_body_entered(enemy)
	
	
	
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
	if body is BaseEnemy:
		print("the body is")
		body.health = body.health - 1
