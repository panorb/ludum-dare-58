class_name Interactable
extends Area2D

@export var active = true

func _ready() -> void:
	$ButtonPromptSprite.visible = false

# activates interactable so that it becomes usable again
func activate():
	active = true
	$CollisionShape2D.disabled = false

# deactivates interactable, can no longer be used until re-activated
func deactivate():
	active = false
	$CollisionShape2D.disabled = true
	$ButtonPromptSprite.visible = false

# if true, show the button prompt
func can_detect(): # overwrite in child scenes & scripts
	return true

# if true, player can successfully interact
func can_trigger(): # overwrite in child scenes & scripts
	return true

# what should happen when the player interacts
func on_trigger(): # overwrite in child scenes & scripts
	print("Trigger pressed, but behavior not overwritten!")

# what should happen if the player tries to interact, but it doesn't work
func on_trigger_failed(): # overwrite in child scenes & scripts
	print("Cannot interact -> not triggered")

# try to interact with the interactable
func trigger():
	if get_tree().get_first_node_in_group("cutscene_conductor").is_playing_cutscene():
		return
	
	$ButtonPromptSprite.visible = false
	
	if can_trigger():
		on_trigger()
	else:
		on_trigger_failed()

# becomes targeted by player
func player_enter():
	if get_tree().get_first_node_in_group("cutscene_conductor").is_playing_cutscene():
		return
	
	if not active:
		return
	if not can_detect():
		return
	$ButtonPromptSprite.visible = true

# becomes no longer targeted by player
func player_exit():
	if not active:
		return
	$ButtonPromptSprite.visible = false
