extends Resource

class_name Inventory


var main_slots: Array[Mixture] = []
var main_slots_count: int = 4


func _init():
	main_slots = []

	for i in range(main_slots_count):
		main_slots.append(null)


func add_item_to_main_slot(mixture: Mixture, slot_id: int) -> bool:
	if slot_id >= main_slots_count or main_slots[slot_id] != null:
		return false
	main_slots[slot_id] = mixture
	return true

func pop_item_from_main_slot(slot_id: int) -> Mixture:
	if slot_id >= main_slots_count:
		return null
	var mixture: Mixture = main_slots[slot_id]
	main_slots[slot_id] = null
	return mixture
