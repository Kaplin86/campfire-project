extends Button
@export var scene : PackedScene


func _on_pressed() -> void:
	Transition.goToPackedScene(scene)
	disabled = true
