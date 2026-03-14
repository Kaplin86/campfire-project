extends HSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_linear(0,value/100)


func _on_check_box_pressed() -> void:
	pass # Replace with function body.
