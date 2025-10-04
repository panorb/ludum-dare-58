class_name Interactable
extends Area2D

#func _ready() -> void:
#	body_entered.connect(_on_player_entered)
#	body_exited.connect(_on_player_exited)

@export var active = true

func activate():
	active = true
func deactivate():
	active = false
	$ButtonPromptSprite.visible = false

func can_detect():
	print("default detect")
	return true

func can_interact():
	print("default interact")
	return true

func on_trigger(): # overwrite in child scenes & scripts
	print("Trigger pressed, but behavior not overwritten!")

func trigger():
	if can_interact():
		on_trigger()

func on_player_enter():
	if not active:
		return
	if not can_detect():
		print("cannot detect")
		return
	$ButtonPromptSprite.visible = true

func on_player_exit():
	if not active:
		return
	$ButtonPromptSprite.visible = false
