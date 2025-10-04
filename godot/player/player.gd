extends CharacterBody2D

func _process(delta: float) -> void:
	var horizontal_velocity = 0.0
	
	if Input.is_action_pressed("move_left"):
		horizontal_velocity -= 200
	if Input.is_action_pressed("move_right"):
		horizontal_velocity += 200
	if Input.is_action_just_pressed("jump"):
		velocity.y = -300
	
	velocity.x = horizontal_velocity
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
