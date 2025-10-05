extends Interactable

var open = false

func body_entered() -> void:
	pass
	

func can_detect():
	if open:
		return false
	return get_tree().get_first_node_in_group("journal").has_entry("got_wrench")

func can_trigger():
	if open:
		return false
	return get_tree().get_first_node_in_group("inventory").has_item("wrench")

func on_trigger():
	get_tree().get_first_node_in_group("inventory").remove_item("wrench")
	get_tree().get_first_node_in_group("journal").unlock_entry("opened_meaningless_lock")
	print("lock open")
	open = true
	$StaticBody2D.queue_free()
	deactivate()

func on_trigger_failed():
	print("Ya need a wrench!")
