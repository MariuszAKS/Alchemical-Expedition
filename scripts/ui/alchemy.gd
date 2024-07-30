extends Control


var path_base:String = "MarginOuter/MarginInner/VBoxContainer/TopRow"
var slots_count:int = 4
var slot_pressed = null
var slots_contents:Array[Crystal] = []

@onready var item_list:ItemList = get_node(path_base + "/ItemList")
@onready var alchemy_slots:Array[TextureButton] = [
	get_node(path_base + "/AlchemyCircle/Top"),
	get_node(path_base + "/AlchemyCircle/Left"),
	get_node(path_base + "/AlchemyCircle/Right"),
	get_node(path_base + "/AlchemyCircle/Bottom"),
]
@onready var alchemy_slots_contents_textures:Array = []

@export var item_texture:CompressedTexture2D


func _ready():
	for i in range(slots_count):
		slots_contents.append(null)
		alchemy_slots_contents_textures.append(alchemy_slots[i].get_node("Margin/Texture"))
		alchemy_slots[i].pressed.connect(_on_slot_pressed.bind(i))
	item_list.item_selected.connect(_on_item_selected)

	for item in Inventory.items:
		item_list.add_item(item.name + " " + Crystal.CrystalType.find_key(item.type), item_texture)


func _on_item_selected(index:int):
	if slot_pressed == null:
		return
	
	slots_contents[slot_pressed] = Inventory.items[index]
	alchemy_slots_contents_textures[slot_pressed].texture = item_texture


func _on_slot_pressed(id:int):
	if alchemy_slots[id].button_pressed:
		_untoggle_slots(id)
		slot_pressed = id
	else:
		slot_pressed = null

func _untoggle_slots(exception_id:int):
	for i in range(slots_count):
		if i == exception_id:
			continue
		alchemy_slots[i].set_pressed(false)
