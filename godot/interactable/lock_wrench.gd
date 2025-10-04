extends Interactable

var open = false

func can_detect():
	if open:
		return false
	return %Inventory.has_item("wrench")

func can_interact():
	if open:
		return false
	print("Im a lock and I want a wrench!")
	return %Inventory.has_item("wrench")

func on_trigger():
	if not can_interact():
		return
	%Inventory.remove_item("wrench")
	print("lock open")
	open = true
	deactivate()
