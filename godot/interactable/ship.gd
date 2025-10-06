extends Interactable

func can_trigger():
	return get_tree().get_first_node_in_group("inventory").has_item("full_battery")

func on_trigger():
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("final_dialog")

func on_trigger_failed():
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("ship_needs_battery")
