extends Node2D

var playerScene:PackedScene = preload("res://scenes/player.tscn")

var mapScene:PackedScene = preload("res://scenes/map.tscn")
var houseScene:PackedScene = preload("res://scenes/locations/house.tscn")
var forestScene:PackedScene = preload("res://scenes/locations/forest.tscn")

@onready var ui_control:Control = get_node("UI Control")

@onready var player:Player = playerScene.instantiate()

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

	_load_location("house")

	_set_player_position()
	_set_player_permissions()

	ui_control.add_child(map)
	_hide_map()

	house.exit_house_area_entered.connect(_show_map)
	map.location_button_pressed.connect(_go_to_location)


func _show_map():
	map.visible = true
	player.enable_move(false)

func _hide_map():
	map.visible = false
	player.enable_move(true)


func _go_to_location(location:String):
	if location in location_dictionary:
		_unload_location()
		_load_location(location)

		_set_player_position()
		_set_player_permissions()

		_hide_map()


func _unload_location():
	loaded_location.remove_child(player)
	remove_child(loaded_location)

func _load_location(location:String):
	loaded_location = location_dictionary[location]
	loaded_location.add_child(player)
	add_child(loaded_location)

func _set_player_position():
	player.global_position = loaded_location.get_node("PlayerStartPosition").global_position

func _set_player_permissions():
	if loaded_location == location_dictionary["house"]:
		player.enable_attack(false)
		player.enable_camera(false)
	else:
		player.enable_attack(true)
		player.enable_camera(true)
