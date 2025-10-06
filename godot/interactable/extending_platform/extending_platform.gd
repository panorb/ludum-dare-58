extends Node2D

func on_puzzle_solved():
	extend_platform()

func extend_platform():
	$CollisionShape2D.disabled = false
	$AudioStreamPlayer.play()
	$AnimatedSprite2D.play("extending")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("extended")
