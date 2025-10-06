extends Node2D

func _ready() -> void:
	set_level("Hangar", "")
	add_to_group("game")
	#ProjectSettings.set_setting("physics/2d/default_gravity", 490)

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
