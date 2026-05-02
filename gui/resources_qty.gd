extends Node2D

@onready var wheat_qty = $box/wheat/qty
@onready var egg_qty = $box/egg/qty

func _process(delta: float) -> void:
	wheat_qty.text = str(BaseResources.wheat_stocked)
	egg_qty.text = str(BaseResources.eggs_stocked)
