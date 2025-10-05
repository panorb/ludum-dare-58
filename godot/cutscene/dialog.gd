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


var iter_print_count = 0
func iter_print(msg):
	if iter_print_count % 4 == 0:
		print(msg)

func _process(delta: float) -> void:
	# var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
	var camera: Camera2D = get_tree().get_first_node_in_group("camera")

	# current speaker node: e.g.: alert node oder player,
	# current_speech_bubble_node: displayed textbox
	# we are positioning it here correctly
	if current_speaker_node and current_speech_bubble_node:
		var transform = camera.get_viewport_transform()
		
		# we need to divide the origin according to the scale of the viewport transforms as
		# origin scales with the window size too
		var scaled_origin = Vector2(
			transform.origin.x / transform.x.x ,
			transform.origin.y / transform.y.y
		)
		
		# we want to clip the dialog box later so it isn't out of the viewport
		var bbox = Vector2(current_speech_bubble_node.size)
		var pos = current_speaker_node.global_position + scaled_origin
		
		# clipping: if the bbox of the speechbuble might be out of the window
		#   move it back in
		var camera_viewport_size = camera.get_viewport_rect().size
		if (pos.x + bbox.x ) >= camera_viewport_size.x:
			pos.x -= bbox.x
		
		if (pos.y + bbox.y ) >= camera_viewport_size.y:
			pos.y -= bbox.y
		
		current_speech_bubble_node.position = pos
