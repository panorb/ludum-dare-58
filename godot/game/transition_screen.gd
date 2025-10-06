extends CanvasLayer

signal on_transition_finished
signal on_end_screen_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	# prevent transition screen to get the focus
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	# only used for end screen / credits
	if anim_name == "fade_to_end_screen":
		on_end_screen_finished.emit()
	
	# only used to fade between levels part 1
	elif anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_to_normal")
	# part 2 of transistioning between levels
	elif anim_name == "fade_to_normal":
		color_rect.visible = false # hide color react

func fade_to_end_screen():
	color_rect.visible = true
	animation_player.play("fade_to_end_screen")

func transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")
