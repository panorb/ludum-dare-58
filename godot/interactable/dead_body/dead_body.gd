extends Interactable

func on_trigger():
	var cutscene_conductor: CutsceneConductor = get_tree().get_first_node_in_group("cutscene_conductor")
	cutscene_conductor.start_cutscene("loot_body")

func on_cutscene_signal(value: String):
	if value == "body_state_switch":
		$AnimatedSprite2D.play("looted")
