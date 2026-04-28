extends Node

func _process(delta: float) -> void:
	$level.text = str(PlayerStats.selling_speed)
	$upgrade.tooltip_text = "$" + str(StatsPrices.selling_speed_price)

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.selling_speed_price:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.selling_speed_price
		PlayerStats.selling_speed += 0.05
		StatsPrices.selling_speed_points += 1
		StatsPrices.selling_speed_price = (10 * StatsPrices.selling_speed_points)
	else:
		AudioPlayer.not_allowed()
