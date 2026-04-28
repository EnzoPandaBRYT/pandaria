extends Node

func _ready() -> void:
	$upgrade.tooltip_text = "$" + str(StatsPrices.artesanal_bread_price) + "\n - Desbloqueia a receita do\nPão Artesanal que vale R$2."

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.artesanal_bread_price and StatsPrices.artesanal_bread_points < 4 :
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.artesanal_bread_price
		ShopPrices.bread_s_price += 1
		StatsPrices.artesanal_bread_points += 1
		$upgrade.tooltip_text = "$" + str(StatsPrices.artesanal_bread_price) + "\n - Aumenta o valor do pão artesanal em +R$1\nValor atual: R$" + str(ShopPrices.bread_s_price)
	else:
		AudioPlayer.not_allowed()
		if PlayerStats.power >= 2.0: $upgrade.tooltip_text = "Nível Máximo alcançado!"
