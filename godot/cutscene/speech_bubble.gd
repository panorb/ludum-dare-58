class_name SpeechBubble
extends MarginContainer

var tween : Tween

var text : String = "" :
	set(value):
		if tween:
			tween.kill()
		
		tween = create_tween()
		tween.tween_property(%RichTextLabel, "visible_ratio", 1.0, len(value) * 0.02).from(0.0)
		tween.play()
		%RichTextLabel.text = value
	get:
		return %RichTextLabel.text
