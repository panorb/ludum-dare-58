extends Node2D

func get_camera_limits():
	var rect = $CameraBounds/CollisionShape2D.shape.get_rect()
	rect.position += $CameraBounds/CollisionShape2D.position
	return rect
