extends CharacterBody2D
class_name BaseEnemy

@export var health = 10
@export var maxhp = 10
func _physics_process(delta: float) -> void:
	if not is_on_floor():
			velocity += get_gravity() * delta
	move_and_slide()
		
