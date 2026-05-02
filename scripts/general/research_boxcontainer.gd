extends BoxContainer

@onready var camera = $skill_tree

var current_offset = Vector2(0,0)

func _ready() -> void:
	current_offset = camera.position

func _process(delta: float) -> void:
	print(camera.offset)
	if GuiHandler.in_skilltree:
		if camera.offset.x < 2000 and camera.offset.x > -2000 and camera.offset.y < 2000 and camera.offset.y > -2000:
			if Input.is_action_pressed("move_right"):
				camera.offset += Vector2(5,0)
			if Input.is_action_pressed("move_left"):
				camera.offset += Vector2(-5,0)
			if Input.is_action_pressed("move_up"):
				camera.offset += Vector2(0,-5)
			if Input.is_action_pressed("move_down"):
				camera.offset += Vector2(0,5)
		else:
			camera.offset = Vector2(0,0)
