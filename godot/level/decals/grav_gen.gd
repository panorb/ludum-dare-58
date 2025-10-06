extends Node2D

func _ready() -> void:
	fast()

func slow():
	$HighNoisePlayer.stop()
	$LowNoisePlayer.play()
	$Sprite2D.play("slow")

func fast():
	$LowNoisePlayer.stop()
	$HighNoisePlayer.play()
	$Sprite2D.play("fast")
