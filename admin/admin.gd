extends Node2D

func _on_upgrade_button_up() -> void:
	PlayerStats.money += 500.0
	AudioPlayer.item_sold()
