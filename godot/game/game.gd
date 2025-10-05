extends Node2D

func _ready() -> void:
	set_level($Level1)

func set_level(level):
	var level_cam_bounds = level.get_camera_limits()
	level_cam_bounds.position = level.position   
	$Player.set_camera_limits(level_cam_bounds)
