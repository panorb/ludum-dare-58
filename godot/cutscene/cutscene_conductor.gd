class_name CutsceneConductor
extends Node

@export_dir var cutscene_script_dir : String = "res://cutscene/scripts"
var cutscene_scripts : Dictionary

signal cutscene_signal(value: String)
signal cutscene_finished

func _ready() -> void:
	# get_tree().create_timer(0.3).timeout.connect(_on_timer_timeout)
	var script_files := DirAccess.get_files_at(cutscene_script_dir)
	for script_file in script_files:
		var script_text = FileAccess.get_file_as_string(cutscene_script_dir + "/" + script_file)
		var script_json = JSON.parse_string(script_text)
		cutscene_scripts[script_file.get_basename()] = script_json
	add_to_group("cutscene_conductor")

var advance_cooldown := 0
var active_dialog_name : String = ""
var cur_instruction := 0

func is_playing_cutscene():
	return active_dialog_name != ""

func start_cutscene(dialog_name):
	assert(dialog_name in cutscene_scripts)
	%Player.freeze()
	cur_instruction = 0
	
	active_dialog_name = dialog_name
	execute_instruction()

func execute_instruction():
	var active_dialog = cutscene_scripts[active_dialog_name]
	var current_instruction = active_dialog[cur_instruction]
	
	var instruction_type = current_instruction["type"]
	
	match instruction_type:
		"speech":
			%Dialog.visible = true
			advance_cooldown = 2.0
			var bubble_text = current_instruction["text"]
			var speaker = "speaker_{0}".format([current_instruction["speaker"]])
			%Dialog.display_bubble(bubble_text, speaker)
		"item_pickup":
			var item = current_instruction["item"]
			%Inventory.add_item(item)
			advance_cutscene()
		"queue_free":
			var group = current_instruction["group"]
			var node = get_tree().get_first_node_in_group(group)
			node.queue_free()
			advance_cutscene()
		"player_animation":
			var animation = current_instruction["animation"]
			var wait = current_instruction["wait"] if current_instruction.has("wait") else true
			
			%Player.play_animation(animation, wait)
			if wait:
				await %Player.animation_finished
			advance_cutscene()
		"wait":
			var time = current_instruction["time"]
			await get_tree().create_timer(time).timeout
			advance_cutscene()
		"signal":
			var value = current_instruction["value"]
			cutscene_signal.emit(value)
			advance_cutscene()
		"unlock_journal_entry":
			var entry = current_instruction["entry"]
			%Journal.unlock_entry(entry)
			advance_cutscene()
		"fade_out_bgm":
			# credits should roll in
			%BGM.fade_out_bgm()
			
			TransitionScreen.fade_to_end_screen() # global variable
			await TransitionScreen.on_end_screen_finished
			%Inventory.visible = false
			%Journal.visible = false
			advance_cutscene()
		"fade_in_bgm":
			%BGM.fade_in_bgm()
			advance_cutscene()
		"play_bgm":
			var track = current_instruction["track"]
			%BGM.play_track(track)
			advance_cutscene()
		"unfreeze":
			%Player.unfreeze()
			advance_cutscene()
		"hide_logo":
			var logo = get_tree().get_first_node_in_group("logo")
			var tween = get_tree().create_tween()
			tween.tween_property(logo, "self_modulate", Color.TRANSPARENT, 3.0).set_trans(Tween.TRANS_CUBIC)
			advance_cutscene()
		_:
			print("Cutscene encountered unknown type: '{0}'".format([instruction_type]))
			advance_cutscene()

func _on_cutscene_end():
	%Dialog.hide_bubble()
	active_dialog_name = ""
	cur_instruction = 0
	%Player.unfreeze()
	cutscene_finished.emit()

func advance_cutscene():
	cur_instruction += 1
	%Dialog.visible = false
	
	if cur_instruction < len(cutscene_scripts[active_dialog_name]):
		execute_instruction()
	else:
		_on_cutscene_end()

func _process(delta: float) -> void:
	if is_playing_cutscene() and advance_cooldown <= 0 and Input.is_action_just_pressed("interact"):
		var active_dialog = cutscene_scripts[active_dialog_name]
		var current_instruction = active_dialog[cur_instruction]
		if current_instruction["type"] == "speech":
			advance_cutscene()
	advance_cooldown -= delta
