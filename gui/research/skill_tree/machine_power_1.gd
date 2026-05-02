extends Node

func _ready() -> void:
	$upgrade.tooltip_text = "$" + str(StatsPrices.power_price) + "\nAumenta seu ⚡poder em +10%."

func _process(delta: float) -> void:
	if PlayerStats.power < 1.5:
		$level.text = "⚡+" + str(PlayerStats.power*100) + "/150%"
	else:
		$level.text = "⚡+150%"

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.power_price and PlayerStats.power != 1.5:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.power_price
		PlayerStats.power += 0.1
		StatsPrices.power_points += 1
		StatsPrices.power_price += (10 * (StatsPrices.power_points))
		$upgrade.tooltip_text = "$" + str(StatsPrices.power_price) + "\nAumenta seu ⚡poder em +10%."
		if PlayerStats.power >= 1.5: $upgrade.tooltip_text = "Nível Máximo alcançado!"
	else:
		AudioPlayer.not_allowed()
