extends Interactable

var open = false

func can_detect():
	if open:
		return false
	return get_tree().get_first_node_in_group("inventory").has_item("wrench")

func can_trigger():
	if open:
		return false
	return get_tree().get_first_node_in_group("inventory").has_item("wrench")

func on_trigger():
	get_tree().get_first_node_in_group("inventory").remove_item("wrench")
	print("lock open")
	open = true
	deactivate()

func on_trigger_failed():
	print("Ya need a wrench!")
