extends Node2D

func _ready() -> void:
	set_level("Level1", "")
	add_to_group("game")

func set_level(level_name, entrance):
	var level = get_node(level_name)
	print(level)
	var level_cam_bounds = level.get_camera_limits()
	print(level_cam_bounds)
	level_cam_bounds.position += level.position
	print(level_cam_bounds)
	$Player.set_camera_limits(level_cam_bounds)
	if entrance:
		var entry_point = level.get_node(entrance).position + level.position
		$Player.position = entry_point
		print(entry_point)
