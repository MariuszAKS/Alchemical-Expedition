extends Node2D


var tree_scene:PackedScene = preload("res://scenes/tree.tscn")

@onready var trees_container:Node2D = get_node("TreesContainer")

var trees:Array[Node2D]
var player:CharacterBody2D


func _ready():
	if trees == []:
		trees = []
		var tree

		var rng = RandomNumberGenerator.new()
		var pos_origin = Vector2(1, 1) * -2000.0
		var pos_shift
		var pos_random

		for x in range(20):
			for y in range(20):
				tree = tree_scene.instantiate()
				trees.append(tree)
				trees_container.add_child(tree)

				pos_shift = Vector2(x, y) * 200.0
				pos_random = (Vector2(rng.randf(), rng.randf()) * 160.0) + (Vector2(1, 1) * 20.0)
				tree.position = pos_origin + pos_shift + pos_random
		
func _enter_tree():
	player = get_node("Player")

func _process(delta):
	for tree in trees:
		if tree.position.y > player.position.y:
			tree.modulate.a = 0.4
		else:
			tree.modulate.a = 1.0
