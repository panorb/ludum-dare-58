extends Interactable

@export var target = "Level1"
@export var entrance = "Level1Entrance"

func on_trigger():
	print("TODO switch to level "+target)
	get_tree().get_first_node_in_group("game").set_level(target, entrance)
