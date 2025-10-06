extends Interactable

@export var dialogs: Array[String] = []
@export var stop_after_last = true

var dialog_counter = 0

func can_detect():
	if dialog_counter >= dialogs.size():
		if stop_after_last:
			return false
		dialog_counter = dialogs.size()-1
	var dialog = dialogs[dialog_counter]
	dialog_counter += 1
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene(dialog)
	return false

func can_trigger():
	return true

func on_trigger():
	pass
