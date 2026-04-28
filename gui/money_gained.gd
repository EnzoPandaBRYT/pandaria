extends Node2D

func _on_money_anim_animation_finished(anim_name: StringName) -> void:
	PlayerStats.money_gained = 0
