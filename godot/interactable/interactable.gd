class_name Interactable
extends Area2D

func _ready() -> void:
	body_entered.connect(_on_player_entered)
	body_exited.connect(_on_player_exited)

func on_trigger(): # overwrite in child scenes & scripts
	print("Trigger pressed, but behavior not overwritten!")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		on_trigger()

func _on_player_entered(body):
	$ButtonPromptSprite.visible = true

func _on_player_exited(body):
	$ButtonPromptSprite.visible = false
