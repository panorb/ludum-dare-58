class_name SpeechBubble
extends MarginContainer

var tween : Tween

var text : String = "" : get = _get_text, set = _set_text

func _get_text():
	return %RichTextLabel.text

func _set_text(value: String):
	if tween:
		tween.kill()
	
	if len(value) > 25:
		custom_minimum_size.x = 200.0
	elif len(value) > 20:
		custom_minimum_size.x = 170.0
	elif len(value) > 15:
		custom_minimum_size.x = 140.0
	
	await get_tree().process_frame
	
	tween = create_tween()
	tween.tween_property(%RichTextLabel, "visible_ratio", 1.0, len(value) * 0.02).from(0.0)
	tween.play()
	
	%RichTextLabel.text = value
	visible = true

func get_visible_rect():
	return %RichTextLabel.get_visible_content_rect()
