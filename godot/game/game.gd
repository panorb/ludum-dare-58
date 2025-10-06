extends Node2D

func _ready() -> void:
	set_level("Hangar", "")
	add_to_group("game")
	#ProjectSettings.set_setting("physics/2d/default_gravity", 490)
	$BGM.play_track(1)
	#get_tree().create_timer(20.0).timeout.connect($BGM.play_track.bind(2))
	#get_tree().create_timer(40.0).timeout.connect($BGM.play_track.bind(3))
	#get_tree().create_timer(65.0).timeout.connect($BGM.play_track.bind(4))

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
