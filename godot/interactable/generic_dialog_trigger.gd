extends Interactable

@export var dialogs: Array[String] = []

var dialog_counter = 0

func can_detect():
	return dialogs.size() > 0

func on_trigger():
	var dialog = dialogs[dialog_counter]
	dialog_counter = min(dialogs.size()-1, dialog_counter+1)
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene(dialog)
