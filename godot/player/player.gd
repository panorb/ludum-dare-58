class_name Player
extends CharacterBody2D

@onready var speaker_position_marker : Marker2D = $SpeakerPosition

var interactables_in_reach = []
var closest_interactable = null

signal animation_finished

var frozen = false

func freeze():
	frozen = true

func unfreeze():
	frozen = false

func _ready():
	$InteractionReach.area_entered.connect(add_interactable)
	$InteractionReach.area_exited.connect(remove_interactable)

func add_interactable(interactable):
	if not interactable is Interactable:
		return
	interactables_in_reach.append(interactable)

func remove_interactable(interactable):
	if not interactable is Interactable:
		return
	interactables_in_reach.erase(interactable)

func set_camera_limits(rect):
	print(rect)
	$Camera2D.limit_left = rect.position.x
	$Camera2D.limit_top = rect.position.y
	$Camera2D.limit_right = rect.position.x + rect.size.x
	$Camera2D.limit_bottom = rect.position.y + rect.size.y
	print($Camera2D.limit_left)
	print($Camera2D.limit_top)
	print($Camera2D.limit_right)
	print($Camera2D.limit_bottom)

func play_animation(anim_name: String, emit_signal: bool):
	$AnimatedSprite2D.play(anim_name)
	await $AnimatedSprite2D.animation_finished
	if emit_signal:
		animation_finished.emit()

func _process(delta: float) -> void:
	var horizontal_velocity = 0.0
	
	if not frozen:
		if Input.is_action_pressed("move_left"):
			horizontal_velocity -= 200
		if Input.is_action_pressed("move_right"):
			horizontal_velocity += 200
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = -385
	
	if abs(velocity.y) > 2:
		$AnimatedSprite2D.play("jump")
	if abs(velocity.y) < 2 and $AnimatedSprite2D.animation == "jump":
		$AnimatedSprite2D.play("idle")
	
	if abs(velocity.x) > 10 and is_on_floor() and $AnimatedSprite2D.animation == "idle":
		$AnimatedSprite2D.play("running")
	elif abs(velocity.x) < 10 and is_on_floor() and $AnimatedSprite2D.animation == "running":
		$AnimatedSprite2D.play("idle")
	
	if abs(velocity.x) > 10:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	velocity.x = horizontal_velocity
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
	# Interactables
	if interactables_in_reach.size() > 0 and velocity != Vector2.ZERO:
		var closest = interactables_in_reach[0]
		if interactables_in_reach.size() > 1:
			var closest_dist = position.distance_squared_to(closest.position)
			for interactable in interactables_in_reach:
				var dist = position.distance_squared_to(interactable.position)
				if dist < closest_dist:
					closest = interactable
					closest_dist = dist
		if closest != closest_interactable:
			if closest_interactable != null:
				closest_interactable.player_exit()
			closest_interactable = closest
			closest_interactable.player_enter()
	elif interactables_in_reach.size() == 0:
		if closest_interactable != null:
			closest_interactable.player_exit()
			closest_interactable = null
	if Input.is_action_just_pressed("interact") and closest_interactable != null and not frozen:
		closest_interactable.trigger()
