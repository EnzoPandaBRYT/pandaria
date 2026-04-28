extends Node

var pressed = false

@onready var button = $collect
@onready var bar = $progressbar
@onready var label = $label

@onready var warning_anim = $"../../../warnings/warning_anim"

func _process(delta: float) -> void:
	label.text = str(Products.bread_stocked)
	if pressed:
		bar.value += (0.5 * PlayerStats.power)
		if bar.value == 100:
			AudioPlayer.collector_free()
			Products.bread_stocked += randi_range(1, PlayerStats.max_production)
			pressed = false
			button.disabled = false
			
	if !pressed:
		if bar.value > 0:
			bar.value -= (10 * PlayerStats.power)


func _on_collect_button_up() -> void:
	if BaseResources.wheat_stocked >= 2:
		AudioPlayer.collector_clicked()
		BaseResources.wheat_stocked -= 2
		pressed = true
		button.disabled = true
		button.tooltip_text = ""
	else:
		AudioPlayer.not_allowed()
		button.tooltip_text = "Você precisa de:\n - 2x Farinha\npara fazer essa receita!"
		if !warning_anim.is_playing():
			warning_anim.play("not_enough_resources")
