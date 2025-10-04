extends Node2D

var items = []

func _ready():
	pass

func add_item(item, count=1):
	for i in range(count):
		items.append(item)

func remove_item(item, count=1):
	for i in range(count):
		items.erase(item)

func has_item(item, count=1):
	var has_count = items.count(item)
	return has_count >= count
