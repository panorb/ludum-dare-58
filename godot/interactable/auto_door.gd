extends Area2D

@export var target = "Level1"
@export var entrance = "Level1Entrance"

func _ready() -> void:
	body_entered.connect(on_player_entered)

func on_player_entered(body):
	print("body entered")
	if body is not CharacterBody2D:
		return
	print("player entered")
	body.velocity = Vector2.ZERO
	get_tree().get_first_node_in_group("game").set_level(target, entrance)
