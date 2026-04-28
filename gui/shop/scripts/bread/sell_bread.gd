extends Node2D

var pressed = false

@onready var button = $sell_button
@onready var bar = $progressbar
@onready var stocked = $qty

## Money Plus Handler
@onready var money_anim = $"../../../../money/money_anim"
@onready var money_gain_label = $"../../../../money/money_gained"

func _process(delta: float) -> void:
	stocked.text = str(Products.bread_stocked)
	if pressed:
		if bar.value >= 100:
			AudioPlayer.item_sold()
			PlayerStats.money += (Products.bread_stocked * ShopPrices.bread_s_price)
			PlayerStats.money_gained += (Products.bread_stocked * ShopPrices.bread_s_price)
			money_gain_label.text = "+R$" + str(PlayerStats.money_gained)
			money_anim.play("blink_plus")
			Products.bread_stocked = 0
			bar.value = 0
			button.disabled = false
			pressed = false
			bar.visible = false
		else:
			bar.value += (0.5 * PlayerStats.selling_speed)
		

func _on_sell_button_button_up() -> void:
	if Products.bread_stocked > 0:
		AudioPlayer.collector_clicked()
		pressed = true
		button.disabled = true
		bar.visible = true
	else:
		AudioPlayer.not_allowed()
		
