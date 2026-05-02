extends TabContainer

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("number_1"):
		current_tab = 0
	if Input.is_action_just_pressed("number_2"):
		current_tab = 1
