extends Control

@export_dir var dialog_script_dir : String = "res://dialog/scripts"
var dialog_scripts : Dictionary

func _ready() -> void:
	# get_tree().create_timer(0.3).timeout.connect(_on_timer_timeout)
	var script_files := DirAccess.get_files_at(dialog_script_dir)
	for script_file in script_files:
		var script_text = FileAccess.get_file_as_string(dialog_script_dir + "/" + script_file)
		var script_json = JSON.parse_string(script_text)
		dialog_scripts[script_file.get_basename()] = script_json
	
	print(dialog_scripts)
	start_dialog("wrench_pickup")

var active_dialog_name : String = ""
var cur_line := 0

func start_dialog(dialog_name):
	assert(dialog_name in dialog_scripts)
	cur_line = 0
	
	active_dialog_name = dialog_name
	execute_line()

func execute_line():
	var active_dialog = dialog_scripts[active_dialog_name]
	var current_instruction = active_dialog[cur_line]
	
	var instruction_type = current_instruction["type"]
	
	match instruction_type:
		"speech":
			# TODO: Handle speaker, so that "people"/objects other than the player can speak
			var bubble_text = current_instruction["text"]
			$SpeechBubble.text = bubble_text
		_:
			print("Dialog encountered unknown type: '{}'".format(instruction_type))

func advance_dialog():
	cur_line += 1
	
	if cur_line < len(dialog_scripts[active_dialog_name]):
		execute_line()
	else:
		active_dialog_name = ""
		cur_line = 0

func _process(delta: float) -> void:
	if active_dialog_name != "" and Input.is_action_just_pressed("interact"):
		advance_dialog()

#func _on_timer_timeout() -> void:
#	$SpeechBubble.text = "Hallo. Das ist ein neuer sehr sehr coolor Text der nie zuvor da war. Wow. Schau ihn dir da hin. Da läuft er. Und gleich ist er vorbei. Jetzt ist er vorbei. Wow."
