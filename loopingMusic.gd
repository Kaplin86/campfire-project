extends AudioStreamPlayer


func _on_finished() -> void:
	pitch_scale = randf_range(0.98,1.02)
	play()
