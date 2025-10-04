extends Interactable

func on_trigger():
	print("Im a wrench and I am cool!")
	%Inventory.add_item("wrench")
	queue_free()
