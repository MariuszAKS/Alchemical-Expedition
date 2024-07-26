extends Node2D

var playerScene:PackedScene = preload("res://scenes/player.tscn")

var mapScene:PackedScene = preload("res://scenes/map.tscn")
var houseScene:PackedScene = preload("res://scenes/locations/house.tscn")
var forestScene:PackedScene = preload("res://scenes/locations/forest.tscn")

@onready var ui_control:Control = get_node("UI Control")

@onready var player:CharacterBody2D = playerScene.instantiate()

@onready var map:Control = mapScene.instantiate()
@onready var house:Node2D = houseScene.instantiate()
@onready var forest:Node2D = forestScene.instantiate()

var location_dictionary:Dictionary
var loaded_location:Node2D = null;


func _ready():
	location_dictionary = {
		"house": house,
		"forest": forest,
	}

	print(house)
	print(location_dictionary)
	_go_to_location("house")

	ui_control.add_child(map)
	_on_map_hide()

	house.exit_house_area_entered.connect(_on_map_show)
	map.location_button_pressed.connect(_go_to_location)


func _on_map_show():
	map.visible = true
	player.can_move = false

func _on_map_hide():
	map.visible = false
	player.can_move = true


func _go_to_location(location:String):
	if location in location_dictionary:
		if loaded_location != null:
			loaded_location.remove_child(player)
			remove_child(loaded_location)
		loaded_location = location_dictionary[location]
		add_child(loaded_location)
		loaded_location.add_child(player)
		player.global_position = loaded_location.get_node("PlayerStartPosition").global_position

		_on_map_hide()
