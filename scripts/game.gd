extends Node2D

var playerScene:PackedScene = preload("res://scenes/player.tscn")

var house_scene:PackedScene = preload("res://scenes/locations/house.tscn")
var forest_scene:PackedScene = preload("res://scenes/locations/forest.tscn")

@onready var player:Player = playerScene.instantiate()

@onready var ui_control:CanvasLayer = get_node("UIControl")
@onready var alchemy:Control = ui_control.get_node("Alchemy")
@onready var map:Control = ui_control.get_node("Map")
@onready var button_house:Button = ui_control.get_node("Button")

@onready var location_container:Node2D = get_node("LocationContainer")
@onready var house:Node2D = house_scene.instantiate()
@onready var forest:Node2D = forest_scene.instantiate()

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

	_hide_alchemy()
	_hide_map()
	button_house.visible = false

	house.cauldron_area_entered.connect(_show_alchemy)
	alchemy.exit_button_pressed.connect(_hide_alchemy)
	house.exit_house_area_entered.connect(_show_map)
	map.location_button_pressed.connect(_go_to_location)


func _show_alchemy():
	alchemy.visible = true
	player.enable_move(false)

func _hide_alchemy():
	alchemy.visible = false
	player.enable_move(true)


func _show_map():
	map.visible = true
	player.enable_move(false)

func _hide_map():
	map.visible = false
	player.enable_move(true)


func _go_to_location(location:String):
	if location in location_dictionary:
		_hide_map()

		_unload_location()
		_load_location(location)

		_set_player_position()
		_set_player_permissions()

		if location == "house":
			button_house.visible = false
		else:
			button_house.visible = true


func _unload_location():
	loaded_location.remove_child(player)
	location_container.remove_child(loaded_location)

func _load_location(location:String):
	loaded_location = location_dictionary[location]
	loaded_location.add_child(player)
	location_container.add_child(loaded_location)

func _set_player_position():
	player.global_position = loaded_location.get_node("PlayerStartPosition").global_position

func _set_player_permissions():
	if loaded_location == location_dictionary["house"]:
		player.enable_attack(false)
		player.enable_camera(false)
	else:
		player.enable_attack(true)
		player.enable_camera(true)


func _go_back_home():
	_go_to_location("house")
