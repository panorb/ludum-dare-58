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


var skip = 0
func iter_print(msg):
	if skip % 4 == 0:
		print(msg)

func _process(delta: float) -> void:
	skip = skip + 1
	var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
	var camera: Camera2D = get_tree().get_first_node_in_group("camera")
	var t = get_viewport_rect()
	#iter_print(t)
	# print("t: {0}".format([t]))
	#iter_print("camera:\n\tviewport_rect: {0}\n\ttransform: {1}".format([camera.get_viewport_rect(),  camera.get_viewport_transform()]))
	#iter_print("player: P:{0}, GP:{1}".format([player.position,player.global_position]))
	
	#if current_speaker_node:
	#	print("speaker global pos: {0}".format([current_speaker_node.global_position]))
	
	# var camera_topleft = camera.global_position - (get_window().size / 2.0)
	# print(camera_topleft)
	
	if current_speaker_node and current_speech_bubble_node:
		var origin = camera.get_viewport_transform().origin
		#iter_print("cspn:\n\tp: {0}\n\t gp: {1}".format([current_speaker_node.position, current_speaker_node.global_position]))
		current_speech_bubble_node.position = current_speaker_node.global_position + origin
		# current_speech_bubble_node.position.y = current_speaker_node.global_position.y + origin.y
		#iter_print("box: {0}".format([current_speech_bubble_node.position]))
		# var viewport_pos = get_viewport().get_visible_rect().position
		# print(t)
		# current_speech_bubble_node.position = current_speaker_node.global_position
		# current_speech_bubble_node.position = current_speaker_node.global_position # + camera.global_position + (get_window().size / 2.0)
	
