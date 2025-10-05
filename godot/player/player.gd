extends CharacterBody2D

var interactables_in_reach = []
var closest_interactable = null

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
	$Camera2D.limit_left = rect.position.x
	$Camera2D.limit_top = rect.position.y
	$Camera2D.limit_right = rect.position.x + rect.size.x
	$Camera2D.limit_bottom = rect.position.y + rect.size.y

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
	if Input.is_action_just_pressed("interact") and closest_interactable != null:
		closest_interactable.trigger()
