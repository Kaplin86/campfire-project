extends Button
@export var scene : String


func _on_pressed() -> void:
	Transition.goToTextScene(scene)
	disabled = true
	await get_tree().create_timer(3).timeout
	disabled = false
