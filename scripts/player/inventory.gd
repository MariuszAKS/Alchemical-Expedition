extends Node


var items:Array[Crystal] = []

var main_slots_count:int = 4
var main_slots:Array[Crystal] = []


func _init():
	main_slots = []

	for i in range(main_slots_count):
		main_slots.append(null)
	
	items.append(Crystal.new("Base ground", Crystal.CrystalType.BASE_GROUND))
	items.append(Crystal.new("Base ground", Crystal.CrystalType.BASE_GROUND))
	items.append(Crystal.new("Base air", Crystal.CrystalType.BASE_AIR))
	items.append(Crystal.new("Base air", Crystal.CrystalType.BASE_AIR))
	items.append(Crystal.new("Boar", Crystal.CrystalType.BOAR))
	items.append(Crystal.new("Boar", Crystal.CrystalType.BOAR))


func add_item(item:Crystal):
	items.append(item)

func remove_item(item:Crystal):
	if item in items:
		items.erase(item)


func add_item_to_main_slot(mixture:Crystal, slot_id:int) -> bool:
	if slot_id >= main_slots_count or main_slots[slot_id] != null:
		return false
	
	main_slots[slot_id] = mixture
	return true

func pop_item_from_main_slot(slot_id:int) -> Crystal:
	if slot_id >= main_slots_count:
		return null
	
	var mixture: Crystal = main_slots[slot_id]
	main_slots[slot_id] = null
	return mixture
