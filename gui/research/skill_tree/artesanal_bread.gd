extends Node

func _ready() -> void:
	$upgrade.tooltip_text = "$" + str(StatsPrices.artesanal_bread_price) + "\n - Desbloqueia a receita do\n🍞 Pão Artesanal que vale R$1.50."

func _on_upgrade_button_up() -> void:
	if PlayerStats.money >= StatsPrices.artesanal_bread_price and ShopPrices.bread_s_price != 2.5:
		AudioPlayer.stat_upgraded()
		PlayerStats.money -= StatsPrices.artesanal_bread_price
		ShopPrices.bread_s_price += 0.5
		StatsPrices.artesanal_bread_points += 1
		StatsPrices.artesanal_bread_price += (20 * StatsPrices.artesanal_bread_points)
		$upgrade.tooltip_text = "$" + str(StatsPrices.artesanal_bread_price) + "\n - Aumenta o valor do pão artesanal em +R$0.50\nValor atual: R$" + str(ShopPrices.bread_s_price)
		if ShopPrices.bread_s_price == 2.5: $upgrade.tooltip_text = "Nível Máximo alcançado!\nValor atual: R$" + str(ShopPrices.bread_s_price)
	else:
		AudioPlayer.not_allowed()
