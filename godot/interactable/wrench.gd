extends Interactable

func on_trigger():
	%CutsceneConductor.start_cutscene("wrench_pickup")
