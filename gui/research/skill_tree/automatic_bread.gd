extends Node

func _ready() -> void:
	$upgrade.tooltip_text = "$" + str(StatsPrices.automatic_bread_price) + "\nDesbloqueia a \n⚙ automação de Pães."
	$level.text = ""

func _process(delta: float) -> void:
	if PlayerStats.base_resources_capacity >= 30:
		$locked.visible = false

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.automatic_bread_price and PlayerStats.automatic_bread_interval != 2.0:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.automatic_bread_price
		PlayerStats.automatic_bread_interval -= 0.25
		StatsPrices.automatic_bread_points += 1
		StatsPrices.automatic_bread_price += (200 * StatsPrices.automatic_bread_points)
		$upgrade.tooltip_text = "$" + str(StatsPrices.automatic_bread_price) + "\nDiminui a velocidade de pães\nautomáticos em 0.25"
		$level.text = "um a cada " + str(PlayerStats.automatic_bread_interval) + "\nsegundos"
		if PlayerStats.automatic_bread_interval == 2.0: $upgrade.tooltip_text = "Nível Máximo alcançado!"
	else:
		AudioPlayer.not_allowed()
