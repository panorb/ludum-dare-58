extends Interactable

func on_trigger():
	var cutscene_conductor: CutsceneConductor = get_tree().get_first_node_in_group("cutscene_conductor")
	
	if $AnimatedSprite2D.animation != "looted":
		cutscene_conductor.start_cutscene("loot_body")
	else:
		cutscene_conductor.start_cutscene("looted_body")
	
	await cutscene_conductor.cutscene_finished
	$ButtonPromptSprite.visible = true

func on_cutscene_signal(value: String):
	if value == "body_state_switch":
		$AnimatedSprite2D.play("looted")
