extends Control

@export var entries = {
	"got_wrench": "I found left tools. It seems whoever abandoned the station was in a hurry - or simply didn't tidy up...",
	"opened_meaningless_lock": "The amazing wrench opened the lock. It's open now, and that's the end of the story. Opening the lock has achieved nothing. Life is meaningless, just like this lock...",
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
	toast_timer.wait_time = 2.0
	toast_timer.timeout.connect(_on_timer_timeout)
	for entry in entries.keys():
		var new_entry = journal_entry_scene.instantiate()
		all_entries[entry] = new_entry
		%JournalPanel.add_entry(new_entry)

func unlock_entry(entry):
	if entry not in entries.keys():
		print("ERROR: unknown journal entry key "+entry)
		return
	unlocked.append(entry)
	$ToastPanel.visible = true
	toast_timer.start()
	var new_entry = all_entries[entry]
	#var new_entry = journal_entry_scene.instantiate()
	new_entry.set_text(entries[entry])
	new_entry.unlock()
	#new_entry.set_text(entries[entry])
	unread.append(new_entry)
	

func has_entry(entry):
	return entry in unlocked

func _on_timer_timeout():
	$ToastPanel.visible = false

func open_journal():
	%JournalPanel.visible = true

func close_journal():
	%JournalPanel.visible = false
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
