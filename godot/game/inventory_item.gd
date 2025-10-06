extends Control

@export var item_icons : Dictionary = {
	"wrench": preload("res://interactable/wrench.png"),
	"id_card1": preload("res://ui/inventory_items/id_card.png"),
	"id_card2": preload("res://ui/inventory_items/id_card2.png"),
	"hose": preload("res://ui/inventory_items/hose.png"),
	"full_battery": preload("res://ui/inventory_items/full_battery.png"),
	"wirecutter": preload("res://ui/inventory_items/wirecutter_inventory.png"),
	"cable": preload("res://ui/inventory_items/cable_item.png"),
}

func set_item(item):
	if item not in item_icons.keys():
		print("ERROR: no icon for "+item+", using wrench!")
		item = "wrench"
	$Icon.texture = item_icons[item]
