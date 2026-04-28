extends Node2D

var fullscreen = false

## Shop
@onready var shop_button = $icons/shop/open_shop_frame/open_shop
@onready var open_shop = $icons/shop/open_shop_frame
@onready var close_shop = $icons/shop/close_shop_frame

## Research
@onready var research_button = $icons/research/open_research_frame/open_research
@onready var open_research = $icons/research/open_research_frame
@onready var close_research = $icons/research/close_research_frame

## Animations
@onready var gui_anim = $gui_anim
@onready var warning_anim = $warnings/warning_anim
var is_animation_playing = false

func _ready() -> void:
	AudioPlayer.main_theme()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen_toggle") and !fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true
	elif Input.is_action_just_pressed("fullscreen_toggle") and fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false

func _on_open_shop_button_up() -> void:
	var items = [Products.bread_stocked, Products.brioche_stocked]
	if items.any(func(n): return n > 0):
		open_shop.visible = false
		gui_anim.play("open_shop")
		AudioPlayer.open_gui()
	else:
		if !warning_anim.is_playing():
			warning_anim.play("cant_open_bakery")
			AudioPlayer.cant_open_gui()
			shop_button.disabled = true
			

func _on_close_shop_button_up() -> void:
	AudioPlayer.close_gui()
	close_shop.visible = false
	gui_anim.play("close_shop")

func _on_open_research_button_up() -> void:
	var money = PlayerStats.money
	if money >= 10:
		open_research.visible = false
		gui_anim.play("open_research")
		AudioPlayer.open_gui()
	else:
		if !warning_anim.is_playing():
			warning_anim.play("cant_open_research")
			AudioPlayer.cant_open_gui()
			research_button.disabled = true

func _on_close_research_button_up() -> void:
	AudioPlayer.close_gui()
	close_research.visible = false
	gui_anim.play("close_research")

func _on_shop_anim_animation_finished(anim_name: StringName) -> void:
	## Shop
	if anim_name == "open_shop":
		close_shop.visible = true
	if anim_name == "close_shop":
		close_shop.visible = false
		open_shop.visible = true

	## Research
	if anim_name == "open_research":
		close_research.visible = true
	if anim_name == "close_research":
		close_research.visible = false
		open_research.visible = true


func _on_warning_anim_animation_finished(anim_name: StringName) -> void:
	shop_button.disabled = false
	research_button.disabled = false


func _on_check_button_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
