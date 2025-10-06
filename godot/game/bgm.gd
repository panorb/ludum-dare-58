extends Node

var currently_playing : int = -1

func play_track(track_num: int):
	var old_playing = currently_playing
	if old_playing == track_num:
		return
	currently_playing = track_num
	
	var tween = create_tween()
	if old_playing >= 0 and not faded_out:
		var old_playing_node = get_node("BGM" + str(old_playing) + "Player")
		tween.tween_property(old_playing_node, "volume_db", -50, 6)
	
	var new_player_node : AudioStreamPlayer = get_node("BGM" + str(track_num) + "Player")
	tween.tween_property(new_player_node, "volume_db", 0, 6).set_delay(4.0)
	if not new_player_node.playing:
		new_player_node.volume_db = -50
		new_player_node.play()
	tween.play()
	
	await tween.finished

var faded_out = false

func fade_out_bgm():
	if currently_playing <= 0:
		return
	
	faded_out = true
	
	var currently_playing_node = get_node("BGM" + str(currently_playing) + "Player")
	var tween = get_tree().create_tween()
	
	tween.tween_property(currently_playing_node, "volume_db", -50, 4)
	tween.play()

func fade_in_bgm():
	if currently_playing <= 0:
		return
	
	faded_out = false
	
	var currently_playing_node = get_node("BGM" + str(currently_playing) + "Player")
	var tween = get_tree().create_tween()
	
	tween.tween_property(currently_playing_node, "volume_db", 0, 4)
	tween.play()
