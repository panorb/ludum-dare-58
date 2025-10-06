extends Interactable

var open = false

var timer = 0.0
var frame_index = 0
var frames = [0, 1, 2, 3, 4, 4, 2, 0, 0, 0]
var is_custom_playing = true

func _ready():
	$DoorSprite.play("opening")
	$DoorSprite.frame = 0

func body_entered() -> void:
	pass

func can_detect():
	if open:
		return false
	return true

func can_trigger():
	if open:
		return true
	return get_tree().get_first_node_in_group("inventory").has_item("cable")

func on_trigger():
	if open:
		get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("open_security_door3_already_open")
		return
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("open_security_door3")
	get_tree().get_first_node_in_group("inventory").remove_item("cable")
	is_custom_playing = false
	$DoorSprite.play("opening")
	$HydraulicsPlayer.play()
	open = true
	$StaticBody2D.queue_free()
	#await $DoorSprite.animation_finished
	$DoorSprite.play("open")

func on_trigger_failed():
	get_tree().get_first_node_in_group("cutscene_conductor").start_cutscene("open_security_door3_fail")

var cur_clink = 0

func _process(delta: float) -> void:
	if not is_custom_playing:
		return
	timer += delta
	if timer >= 0.1:
		timer = 0.0
		frame_index += 1
		if frame_index >= frames.size():
			frame_index = 0
		$DoorSprite.frame = frames[frame_index]
		if frame_index == 0:
			$HydraulicsPlayer.play()
		
		if frames[frame_index] in [0, 7]:
			cur_clink += 1
			cur_clink %= $Clinks.get_child_count()
			
			$Clinks.get_child(cur_clink).play()
	
