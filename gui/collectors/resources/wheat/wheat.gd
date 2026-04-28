extends Node

var pressed = false

@onready var button = $collect
@onready var bar = $progressbar
@onready var label = $label

func _process(delta: float) -> void:
	label.text = str(BaseResources.wheat_stocked) + "/" + str(BaseResources.wheat_limit)
	if pressed:
		bar.value += (2 * PlayerStats.power)
		if bar.value == 100:
			AudioPlayer.collector_free()
			BaseResources.wheat_stocked += randi_range(1, PlayerStats.max_production)
			pressed = false
			button.disabled = false
			
	if !pressed:
		if bar.value > 0:
			bar.value -= (20 * PlayerStats.power)


func _on_collect_button_up() -> void:
	if BaseResources.wheat_stocked < BaseResources.wheat_limit:
		AudioPlayer.collector_clicked()
		pressed = true
		button.disabled = true
	else:
		AudioPlayer.not_allowed()
