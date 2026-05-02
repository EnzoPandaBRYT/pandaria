extends Node

func _ready() -> void:
	$upgrade.tooltip_text = "$" + str(StatsPrices.capacity_1_price) + "
	A quantidade de recursos básicos,
	como farinha e ovos que você
	pode armazenar no máximo."

func _process(delta: float) -> void:
	if PlayerStats.base_resources_capacity >= 50:
		$level.text = "📦 +50"
	else:
		$level.text = "📦 " + str(PlayerStats.base_resources_capacity) + "/50"

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.capacity_1_price and PlayerStats.base_resources_capacity < 50:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.capacity_1_price
		PlayerStats.base_resources_capacity += 10
		StatsPrices.capacity_1_points += 1
		StatsPrices.capacity_1_price += (50 * (StatsPrices.capacity_1_points))
		$upgrade.tooltip_text = "$" + str(StatsPrices.capacity_1_price) + "
		A quantidade de recursos básicos,
		como farinha e ovos que você
		pode armazenar no máximo."
		if PlayerStats.base_resources_capacity >= 50:
			$upgrade.tooltip_text = "Nível Máximo alcançado!"
			
	else:
		AudioPlayer.not_allowed()
