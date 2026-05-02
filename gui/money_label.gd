extends Label
	
func _process(delta: float) -> void:
	text = "💲 R$" + str(PlayerStats.money) + " 💲"
	tooltip_text = "Seu saldo de R$" + str(PlayerStats.money) + "."
