extends Control

var read = false

func mark_read():
	read = true
	%UnreadMarker.visible = false

func unlock():
	$Background.visible = true
	$LockedBackground.visible = false
	$UnreadMarker.visible = true

func set_text(text):
	if len(text) > 25:
		custom_minimum_size.x = 200.0
	elif len(text) > 20:
		custom_minimum_size.x = 170.0
	elif len(text) > 15:
		custom_minimum_size.x = 140.0
	%RichTextLabel.text = text
