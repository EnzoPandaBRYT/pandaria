extends Node

func _ready() -> void:
	$upgrade.tooltip_text = "$" + str(StatsPrices.power_price) + "\nAumenta seu poder em +5%."

func _process(delta: float) -> void:
	$level.text = "+" + str(PlayerStats.power*100) + "/200%"

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.power_price and PlayerStats.power < 2:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.power_price
		PlayerStats.power += 0.1
		StatsPrices.power_points += 1
		StatsPrices.power_price += (5 * StatsPrices.power_points)
		$upgrade.tooltip_text = "$" + str(StatsPrices.power_price) + "\nAumenta seu poder em +5%."
	else:
		AudioPlayer.not_allowed()
		if PlayerStats.power >= 2.0: $upgrade.tooltip_text = "Nível Máximo alcançado!"
