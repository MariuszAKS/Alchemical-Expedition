extends Node2D


var tree_scene:PackedScene = preload("res://scenes/tree.tscn")
var boar_scene:PackedScene = preload("res://scenes/boar.tscn")

@onready var trees_container:Node2D = get_node("TreesContainer")
@onready var boars_container:Node2D = get_node("BoarsContainer")

var player:CharacterBody2D
var trees:Array[Node2D]
var boars:Array[CharacterBody2D]


func _ready():
	if trees == []:
		var tree

		var pos_origin:Vector2 = Vector2(1, 1) * -2000.0
		var pos_shift:Vector2
		var pos_random:Vector2

		for x in range(20):
			for y in range(20):
				tree = tree_scene.instantiate()
				trees.append(tree)
				trees_container.add_child(tree)

				pos_shift = Vector2(x, y) * 200.0
				pos_random = (Vector2(randf(), randf()) * 160.0) + (Vector2(1, 1) * 20.0)
				tree.position = pos_origin + pos_shift + pos_random
	
	if boars == []:
		var boar

		var pos_origin:Vector2
		var range_min:float = -1500
		var range_max:float = 1500
		var pos_shift:Vector2
		var shift_min:float = -50
		var shift_max:float = 50

		for herd in range(1):
			pos_origin = Vector2(randf_range(range_min, range_max), randf_range(range_min, range_max))

			for member in range(1):
				boar = boar_scene.instantiate()
				boars.append(boar)
				boars_container.add_child(boar)

				pos_shift = Vector2(randf_range(shift_min, shift_max), randf_range(shift_min, shift_max))
				boar.position = pos_origin + pos_shift

		
func _enter_tree():
	player = get_node("Player")

func _process(_delta):
	for tree in trees:
		if tree.position.y > player.position.y:
			tree.modulate.a = 0.4
		else:
			tree.modulate.a = 1.0
