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

func _physics_process(delta: float) -> void:
	$TextureProgressBar.value = health
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
	
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is BaseEnemy:
		print("the body is")
		body.health = body.health - 1
