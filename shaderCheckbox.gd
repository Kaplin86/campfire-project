extends CheckBox



func _on_toggled(toggled_on: bool) -> void:
	ShaderScene.visible = toggled_on
