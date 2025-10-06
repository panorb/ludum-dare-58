extends Interactable

var current_num = -1
signal number_changed(new_value: int)

func on_trigger():
	# deactivate()
	current_num += 1
	current_num = current_num % 10
	
	$ButtonSprite.play("pressed")
	await get_tree().create_timer(0.15).timeout
	$ButtonSprite.play("relaxed")
	await get_tree().create_timer(0.025).timeout
	$EightSegmentDisplaySprite.play(str(current_num))
	# activate()
	# WARNING: Ugly and buggy to do it this way
	$ButtonPromptSprite.visible = true
	number_changed.emit(current_num)
