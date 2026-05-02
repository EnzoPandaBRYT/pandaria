extends Node

func _ready() -> void:
	$upgrade.tooltip_text = "$" + str(StatsPrices.capacity_2_price) + "
	A quantidade de recursos básicos,
	como farinha e ovos que você
	pode armazenar no máximo."

func _process(delta: float) -> void:
	if PlayerStats.base_resources_capacity >= 50:
		$locked.visible = false
	if PlayerStats.base_resources_capacity >= 150:
		$level.text = "📦 +150"
	else:
		$level.text = "📦 " + str(PlayerStats.base_resources_capacity) + "/150"

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.capacity_2_price and PlayerStats.base_resources_capacity < 150:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.capacity_2_price
		PlayerStats.base_resources_capacity += 25
		StatsPrices.capacity_2_points += 1
		StatsPrices.capacity_2_price += (240 * (StatsPrices.capacity_2_points))
		$upgrade.tooltip_text = "$" + str(StatsPrices.capacity_2_price) + "
		A quantidade de recursos básicos,
		como farinha e ovos que você
		pode armazenar no máximo."
		if PlayerStats.base_resources_capacity >= 150:
			$upgrade.tooltip_text = "Nível Máximo alcançado!"
			
	else:
		AudioPlayer.not_allowed()
