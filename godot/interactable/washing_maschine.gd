extends Interactable

var opened = false
var looted = false

func can_trigger():
	if looted:
		return true
	return get_tree().get_first_node_in_group("inventory").has_item("wirecutter")

func on_trigger():
	if looted:
		get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("washing_maschine_looted")
		return
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("washing_maschine")
	$WashingMaschineSprite.play("looted")
	looted = true

func on_trigger_failed():
	if not opened:
		$WashingMaschineSprite.play("opened")
		opened = true
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("washing_maschine_fail")
