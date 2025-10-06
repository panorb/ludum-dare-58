class_name Dialog
extends Control

# edge case for center text as a type
class VoidSpeaker extends Node2D:
	pass

func calc_center_based_upon_length_of_text(viewport_size: Vector2, bbox: Vector2) -> Vector2:
		# returns a position that centers the textbox so that it appears to be in the center
		# of the screen both vertically and horizontally
		# bbox: text bbox
		# viewport size(original resolution): Camera
		var pos: Vector2 = Vector2(
			viewport_size.x - bbox.x ,
			viewport_size.y - bbox.y
		)
		return pos / 2.0 # / 2.0 so we get the middle of the viewport + bbox

func get_viewport_size() -> Vector2:
	var camera = get_tree().get_first_node_in_group("camera")
	return camera.get_viewport_rect().size
	
# class variable so we don't realloc the speaker again and again


@export var speech_bubble_scene : PackedScene = preload("res://cutscene/speech_bubble.tscn")
var current_speaker_node : Node2D

var current_speech_bubble_node : SpeechBubble


func display_bubble(text: String, speaker: String):
	# TODO: Handle speaker
	var speaker_candidates = get_tree().get_nodes_in_group(speaker)
	print(speaker_candidates)
	match speaker:
		"speaker_void": # scene speaker
			current_speaker_node = VoidSpeaker.new()
		"speaker_player":
			assert(len(speaker_candidates) == 1)
			current_speaker_node = speaker_candidates[0]
		_:
			print("unrecognized speaker input {0}".format([speaker]))
	print(current_speaker_node.global_position)
	
	var old_speech_bubble_node = current_speech_bubble_node
	current_speech_bubble_node = speech_bubble_scene.instantiate()
	add_child(current_speech_bubble_node)
	current_speech_bubble_node.text = text
	
	if old_speech_bubble_node:
		old_speech_bubble_node.queue_free()
	

func hide_bubble():
	if current_speech_bubble_node == null:
		return
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
		
		var camera_viewport_size: Vector2 = camera.get_viewport_rect().size
		# we want to clip the ddaialog box later so it isn't out of the viewport
		var bbox = Vector2(current_speech_bubble_node.size)
		# origin position of textbox
		if current_speaker_node is VoidSpeaker:
			current_speaker_node.global_position = calc_center_based_upon_length_of_text(camera_viewport_size, bbox)
			# don't clip textboxes as we know that they shouldn't clip
			current_speech_bubble_node.position = current_speaker_node.global_position
			current_speech_bubble_node.hide_box()
			print("pos: {0}" # scaled: {1}"-+
			.format([current_speech_bubble_node.position]))
			return

		var pos: Vector2 = current_speaker_node.global_position + scaled_origin
		
		
		# clipping: if the bbox of the speechbuble might be out of the window
		#   move it back in
		
		if (pos.x + bbox.x ) >= camera_viewport_size.x:
			pos.x -= bbox.x
		
		if (pos.y + bbox.y ) >= camera_viewport_size.y:
			pos.y -= bbox.y
		
		current_speech_bubble_node.position = pos
