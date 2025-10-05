class_name Dialog
extends Control

var current_speaker_node : Node2D

func display_bubble(text: String, speaker: String):
	# TODO: Handle speaker
	var speaker_candidates = get_tree().get_nodes_in_group(speaker)
	assert(len(speaker_candidates) == 1)
	current_speaker_node = speaker_candidates[0]
	
	$SpeechBubble.visible = true
	$SpeechBubble.text = text
	force_update_transform()

func hide_bubble():
	$SpeechBubble.visible = false

func _process(delta: float) -> void:
	if current_speaker_node:
		$SpeechBubble.position = current_speaker_node.global_position
