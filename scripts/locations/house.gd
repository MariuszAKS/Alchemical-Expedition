extends Node2D


signal cauldron_area_entered
signal exit_house_area_entered


func _on_cauldron_body_entered(body:Node2D):
	if body is Player:
		emit_signal(cauldron_area_entered.get_name())


func _on_exit_body_entered(body:Node2D):
	if body is Player:
		emit_signal(exit_house_area_entered.get_name())
