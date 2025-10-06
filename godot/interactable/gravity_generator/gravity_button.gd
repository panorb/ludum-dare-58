extends Interactable

var times_pressed = 0
var low_gravity = 490
var high_gravity = 980

var is_low_gravity = false

func on_trigger():
	
	$ButtonPressSound.play()
	$ButtonSprite.play("pressed")
	await get_tree().create_timer(0.15).timeout
	$ButtonSprite.play("relaxed")
	await get_tree().create_timer(0.1).timeout
	is_low_gravity = not is_low_gravity
	if is_low_gravity:
		ProjectSettings.set_setting("physics/2d/default_gravity", low_gravity)
		%GravGen.slow()
	else:
		ProjectSettings.set_setting("physics/2d/default_gravity", high_gravity)
		%GravGen.fast()
	# TODO dialog what did this do?
	# only first time, maybe second time
	if times_pressed == 0:
		get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("grav_gen_low_gravity_first_time")
	elif times_pressed == 1:
		get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("grav_gen_high_gravity_first_time")
	else:
		if is_low_gravity:
			get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("grav_gen_low_gravity")
		else:
			get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("grav_gen_high_gravity")
	times_pressed += 1
