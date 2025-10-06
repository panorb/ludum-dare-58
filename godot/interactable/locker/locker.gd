extends Interactable

@export var dialog = "lore_locker"
@export var dialog_empty = "locker_empty"

var looted := false

func on_trigger():
	if looted:
		cutscene_conductor.start_cutscene(dialog_empty)
		return
	cutscene_conductor.start_cutscene(dialog)
	looted = true

func on_cutscene_signal(value: String):
	$AnimatedSprite2D.play(value)
	if value == "open_full" or value == "closed_empty" or (looted and value == "open_empty"):
		$DoorOpenPlayer.play()
