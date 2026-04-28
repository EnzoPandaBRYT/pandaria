extends Node

func _process(delta: float) -> void:
	$level.text = str(PlayerStats.max_production)
	$upgrade.tooltip_text = "$" + str(StatsPrices.max_production_price)

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.max_production_price:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.max_production_price
		PlayerStats.max_production += 1
		StatsPrices.max_production_points += 1
		StatsPrices.max_production_price += (20 * StatsPrices.max_production_points)
	else:
		AudioPlayer.not_allowed()
