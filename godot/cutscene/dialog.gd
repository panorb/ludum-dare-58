class_name Dialog
extends Control

@export var speech_bubble_scene : PackedScene = preload("res://cutscene/speech_bubble.tscn")
var current_speaker_node : Node2D

var current_speech_bubble_node : SpeechBubble

func display_bubble(text: String, speaker: String):
	# TODO: Handle speaker
	var speaker_candidates = get_tree().get_nodes_in_group(speaker)
	assert(len(speaker_candidates) == 1)
	current_speaker_node = speaker_candidates[0]
	
	var old_speech_bubble_node = current_speech_bubble_node
	current_speech_bubble_node = speech_bubble_scene.instantiate()
	add_child(current_speech_bubble_node)
	current_speech_bubble_node.text = text
	
	if old_speech_bubble_node:
		old_speech_bubble_node.queue_free()
	

func hide_bubble():
	current_speech_bubble_node.queue_free()
	current_speech_bubble_node = null
	# $SpeechBubble.visible = false

func _process(delta: float) -> void:
	var camera : Camera2D = get_tree().get_first_node_in_group("camera")
	
	var camera_topleft = camera.global_position - (get_window().size / 2.0)
	print(camera_topleft)
	
	if current_speaker_node and current_speech_bubble_node:
		var viewport_pos = get_viewport().get_visible_rect().position
		current_speech_bubble_node.position = current_speaker_node.global_position - viewport_pos
		# current_speech_bubble_node.position = current_speaker_node.global_position # + camera.global_position + (get_window().size / 2.0)
	
