extends Node2D


signal cauldron_area_entered
signal exit_house_area_entered


func _ready():
	pass


func _on_exit_body_entered(body:Node2D):
	if body is CharacterBody2D:
		emit_signal(exit_house_area_entered.get_name())
