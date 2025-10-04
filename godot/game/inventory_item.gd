extends Control

@export var item_icons : Dictionary = {
	"wrench": preload("res://interactable/wrench.png"),
}

func set_item(item):
	if item not in item_icons.keys():
		print("ERROR: no icon for "+item+", using wrench!")
		item = "wrench"
	$Icon.texture = item_icons[item]
