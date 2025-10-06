extends Control

@export var entries = {
	"hangar_locker": "Found several repair manuals for various ship systems. It must have been severaly damaged by something",
	"hangar_pc_log": "Seems the pilot was asleep and the ship got hit by an asteroid",
	"hangar_sign": "Comprehensive shuttle safety warnings suggest the ship had a shuttle equipped",
	"hangar_sticky": "Found an access code in the hangar: 287",
	"hub1_desk": "The ships a colony ship - it should carry hundreds of people in cryosleep. Why are there no life-signs?",
	"hub1_log": "Some guy named Robert attacked the pilot Edgar.",
	"hub1_locker": "The gravity generator has been overriden and can only be changed manually in engineering",
	"hub3_pc": "The ship's doctor Sarah wants to leave the ships with Edgar and Adam, while Robert works on the antenna.",
	"hub3_desk": "The ship has an AI system called SAI, that's behaving oddly since the accident.",
	"hub3_medpack": "The medical supplies seem to have been used quite a lot, they're almost empty.",
	"hub2_desk": "Apparently Edgar has lied to Sarah about havin calculated the trajectory of the drifting ship",
	"hub2_pc": "Adam removed the restraints of the Ship AI just after the crash.",
	"eng_desk": "The pilot told everyone that the sensors never picked up that asteroid",
	"eng_pc": "The ships passengers have been feed to the bioreactor to keep the AI system running.",
	"pit_locker": "The ships antennas are irrepairably broken, and without them, the location of th ship can never be known.",
	"pit_corpse": "Robert went to disable the bioreactor - seems he never made it",
	"goal_pc": "All passenges have been converted to energy - they are all dead..."
}

var journal_entry_scene = preload("res://game/journal_entry.tscn")

var unlocked = []
@onready var toast_timer = $Timer

var unread = []
var all_entries = {}

func _ready():
	add_to_group("journal")
	$ToastPanel.visible = false
	%JournalPanel.visible = false
	toast_timer.one_shot = true
	toast_timer.wait_time = 3.0
	toast_timer.timeout.connect(_on_timer_timeout)
	for entry in entries.keys():
		var new_entry = journal_entry_scene.instantiate()
		all_entries[entry] = new_entry
		%JournalPanel.add_entry(new_entry)

func unlock_entry(entry):
	if entry not in entries.keys():
		print("ERROR: unknown journal entry key "+entry)
		return
	if entry in unlocked:
		return
	unlocked.append(entry)
	$ToastPanel.visible = true
	toast_timer.start()
	var new_entry = all_entries[entry]
	#var new_entry = journal_entry_scene.instantiate()
	new_entry.set_text(entries[entry])
	new_entry.unlock()
	$NewEntryPlayer.play()
	#new_entry.set_text(entries[entry])
	unread.append(new_entry)

func has_entry(entry):
	return entry in unlocked

func _on_timer_timeout():
	$ToastPanel.visible = false

func open_journal():
	%JournalPanel.visible = true
	%Player.freeze()

func close_journal():
	%JournalPanel.visible = false
	%Player.unfreeze()
	for entry in unread:
		entry.mark_read()
	unread.clear()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("journal"):
		if %JournalPanel.visible:
			close_journal()
		else:
			open_journal()
	if Input.is_action_just_pressed("ui_cancel") and %JournalPanel.visible:
		close_journal()
