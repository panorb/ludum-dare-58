extends Node2D

var items = []

func _ready():
	pass

func add_item(item, count=1):
	for i in range(count):
		items.append(item)
	print("added "+item)

func remove_item(item, count=1):
	for i in range(count):
		items.erase(item)
	print("removed "+item)

func has_item(item, count=1):
	print("asking for "+item)
	var has_count = items.count(item)
	print("have "+str(has_count))
	return has_count >= count
