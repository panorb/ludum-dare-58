extends Node2D

func get_camera_limits():
	return $CameraBounds/CollisionShape2D.shape.get_rect().abs()
