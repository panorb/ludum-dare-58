extends Interactable

var looted = false

func on_trigger():
	if looted:
		cutscene_conductor.start_cutscene("battery_looted")
		return
	cutscene_conductor.start_cutscene("battery_pickup")
	looted = true

func on_cutscene_signal(value: String):
	if value == "looted":
		$AnimatedSprite2D.play("looted")
