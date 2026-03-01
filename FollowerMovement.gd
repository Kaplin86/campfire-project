extends CharacterBody2D
class_name FollowingEntity

@export var health = 5
@export var maxHealth = 5
@export var isImportant = false
@export var distanceBeforeJump = 50
@export var movementSpeed = 6000

var bindedPlayer : PlayerCharacter = null

var gravityStacks = Vector2(0,0)
var JUMP_VELOCITY = -500.0
@onready var navi : NavigationAgent2D = NavigationAgent2D.new()
var RePathTimer = Timer.new()

@onready var healthBar = $TextureProgressBar

func _ready():
	if isImportant:
		Ui.catObjects.append(self)
	add_child(navi)
	add_child(RePathTimer)
	RePathTimer.wait_time = 1

	RePathTimer.start()
	RePathTimer.timeout.connect(makepath);
	navi.debug_enabled = true

func makepath():
	if bindedPlayer:
		navi.target_position = bindedPlayer.global_position
	

func _physics_process(delta: float) -> void:
	
	healthBar.max_value = maxHealth
	healthBar.value = health
	
	if bindedPlayer != null:
		
		var directionToPlayer = navi.get_next_path_position() - global_position
		velocity.x = (directionToPlayer.normalized() * movementSpeed * delta).x
		
	
	# the gravite
	if is_on_floor():
		velocity.y = 0
		
		if bindedPlayer != null:
			var directionToPlayer = bindedPlayer.global_position - global_position
			if $RayCast2D.is_colliding():
				if directionToPlayer.y < -1:
					velocity.y = JUMP_VELOCITY
		
	else:
		velocity.y += get_gravity().y * delta
	
	if abs(velocity.x) <= 0.1 and bindedPlayer != null:
		var directionToPlayer = bindedPlayer.global_position - global_position
		velocity.x += clamp(directionToPlayer.x,-0.1,0.1)
		print("hhhhhhh")
	
	if velocity.x != 0:
		if velocity.x > 0:
			$RayCast2D.target_position.x = 107.0
		else:
			$RayCast2D.target_position.x = -107.0
	
	move_and_slide()


func _on_vision_body_entered(body: Node2D) -> void:
	
	if body is PlayerCharacter:
		bindedPlayer = body
