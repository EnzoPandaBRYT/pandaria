extends CheckButton



func _on_toggled(toggled_on: bool) -> void:
	if !toggled_on:
		AudioServer.set_bus_volume_db(1, -80)
	else:
		AudioServer.set_bus_volume_db(1, -0)
