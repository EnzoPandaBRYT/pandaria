extends Node

var pressed = false
var on_cooldown = false
var can_start_timer = true

@onready var button = $collect
@onready var bar = $progressbar
@onready var label = $label

@onready var warning_anim = $"../../../warnings/warning_anim"

func _process(delta: float) -> void:
	label.text = "📦 " + str(Products.bread_stocked)
	label.tooltip_text = "Quantos pães você tem.\nR$" + str(ShopPrices.bread_s_price) + "0 cada."
	
	if pressed:
		bar.value += (1 * PlayerStats.power)
		if bar.value == 100:
			AudioPlayer.collector_free()
			Products.bread_stocked += randi_range(1, PlayerStats.max_production)
			pressed = false
			button.disabled = false
			
	if !pressed:
		if bar.value > 0:
			bar.value -= (10 * PlayerStats.power)
	
	if BaseResources.wheat_stocked >= 2 and StatsPrices.automatic_bread_points >= 1 and !on_cooldown:
		BaseResources.wheat_stocked -= 2
		pressed = true
		on_cooldown = true
		button.disabled = true
		button.tooltip_text = ""
	elif on_cooldown:
		if can_start_timer:
			$timer.start(PlayerStats.automatic_bread_interval)
			can_start_timer = false
		

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

func _on_timer_timeout() -> void:
	on_cooldown = false
	can_start_timer = true
