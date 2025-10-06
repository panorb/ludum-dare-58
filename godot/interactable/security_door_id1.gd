extends Interactable

var open = false

func body_entered() -> void:
	pass

func can_detect():
	if open:
		return false
	return true

func can_trigger():
	if open:
		return true
	return get_tree().get_first_node_in_group("inventory").has_item("id_card1")

func on_trigger():
	if open:
		get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("open_security_door1_already_open")
		return
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("open_security_door1")
	$CardReaderSprite.play("accept")
	$DoorSprite.play("opening")
	print("lock open")
	open = true
	$StaticBody2D.queue_free()
	await get_tree().create_timer(1).timeout
	$DoorSprite.play("open")

func on_trigger_failed():
	$CardReaderSprite.play("reject")
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("open_security_door1_fail")
	await get_tree().create_timer(3).timeout
	$CardReaderSprite.play("idle")
