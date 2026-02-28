extends CharacterBody2D
class_name BaseEnemy

@export var hp = 10
func _physics_process(delta: float) -> void:
	if not is_on_floor():
			velocity += get_gravity() * delta
			
		
