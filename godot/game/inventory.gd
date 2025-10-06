extends Control

# "full_battery" # to check end screen
var items = []
var display_items = []
var item_scene = preload("res://game/inventory_item.tscn")

func _ready():
	var item_display = $Items
	for item in item_display.get_children():
		item.queue_free()
	display_items.clear()
	add_to_group("inventory")
	print("added to inventory")

func add_item(item, count=1):
	for i in range(count):
		items.append(item)
		var display_item = item_scene.instantiate()
		display_item.set_item(item)
		display_items.append(display_item)
		$Items.add_child(display_item)

func remove_item(item, count=1):
	for i in range(count):
		if item not in items:
			break
		var index = items.find(item)
		items.remove_at(index)
		var display_item = display_items[index]
		display_items.remove_at(index)
		$Items.remove_child(display_item)
		display_item.queue_free()

func has_item(item, count=1):
	var has_count = items.count(item)
	return has_count >= count
