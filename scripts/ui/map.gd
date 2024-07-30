extends Control


signal location_button_pressed(location:String)


func _ready():
	pass


func _on_plains_pressed():
	emit_signal(location_button_pressed.get_name(), "plains")

func _on_forest_pressed():
	emit_signal(location_button_pressed.get_name(), "forest")

func _on_ocean_pressed():
	emit_signal(location_button_pressed.get_name(), "ocean")
