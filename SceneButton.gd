extends Button
@export var scene : PackedScene


func _on_pressed() -> void:
	Transition.goToPackedScene(scene)
	disabled = true
	await get_tree().create_timer(3).timeout
	disabled = false
