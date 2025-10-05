extends Interactable

func on_trigger():
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("wrench_pickup")
