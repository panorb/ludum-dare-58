extends Interactable

func on_trigger():
	cutscene_conductor.start_cutscene("battery_pickup")

func on_cutscene_signal(value: String):
	if value == "looted":
		$AnimatedSprite2D.play("looted")
