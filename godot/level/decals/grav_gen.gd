extends Node2D

func _ready() -> void:
	fast()

func slow():
	$Sprite2D.play("slow")

func fast():
	$Sprite2D.play("fast")
