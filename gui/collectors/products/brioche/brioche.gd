extends Node

var pressed = false

@onready var button = $collect
@onready var bar = $progressbar
@onready var label = $label

func _process(delta: float) -> void:
	label.text = str(Products.brioche_stocked)
	if PlayerStats.power < 1.10 or pressed:
		button.disabled = true
	else:
		$"../../bakery/brioche/locked".visible = false
		button.disabled = false
	if pressed:
		bar.value += (0.2 * PlayerStats.power)
		if bar.value == 100:
			AudioPlayer.collector_free()
			Products.brioche_stocked += 1
			pressed = false
			bar.value = 0
			button.disabled = false

func _on_collect_button_up() -> void:
	AudioPlayer.collector_clicked()
	pressed = true
	button.disabled = true
