extends CanvasLayer

func goToPackedScene(scn : PackedScene):
	Ui.resetVisuals()
	var tween = get_tree().create_tween();
	tween.tween_method(
	  func(value): $ColorRect.material.set_shader_parameter("height", value),  
	  -1.0,  # Start value
	  1.0,  # End value
	  1     # Duration
	);
	await tween.finished
	get_tree().change_scene_to_packed(scn)
	tween = get_tree().create_tween();
	tween.tween_method(
	  func(value): $ColorRect.material.set_shader_parameter("height", value),  
	  1.0,  # Start value
	  -1.0,  # End value
	  1     # Duration
	);


func goToTextScene(scn : String):
	Ui.resetVisuals()
	var tween = get_tree().create_tween();
	tween.tween_method(
	  func(value): $ColorRect.material.set_shader_parameter("height", value),  
	  -1.0,  # Start value
	  1.0,  # End value
	  1     # Duration
	);
	await tween.finished
	get_tree().change_scene_to_file(scn)
	tween = get_tree().create_tween();
	tween.tween_method(
	  func(value): $ColorRect.material.set_shader_parameter("height", value),  
	  1.0,  # Start value
	  -1.0,  # End value
	  1     # Duration
	);
