extends State

@export
var idle_state: State


func handleAnimation() -> void:
	
	parent.animations.play()

	if parent.direction.x > 0:
		if parent.direction.z > 0:
			#parent.animations.play("run_down_right")
			parent.animations.animation = "run_down_right"
		elif parent.direction.z < 0:
			#parent.animations.play("run_up_right")
			parent.animations.animation = "run_up_right"
		else:
			#parent.animations.play("run_right")
			parent.animations.animation = "run_right"
	elif parent.direction.x < 0:
		if parent.direction.z > 0:
			#parent.animations.play("run_down_left")
			parent.animations.animation = "run_down_left"
		elif parent.direction.z < 0:
			#parent.animations.play("run_up_left")
			parent.animations.animation = "run_up_left"
		else:
			#parent.animations.play("run_left")
			parent.animations.animation = "run_left"
	else:
		if parent.direction.z > 0:
			#parent.animations.play("run_down")
			parent.animations.animation = "run_down"
		else:
			#parent.animations.play("run_up")
			parent.animations.animation = "run_up"


func process_physics(delta: float) -> State:
	
	if Input.is_action_pressed("move_right"):
		print('right')
		parent.direction.x = parent.direction.x + 1
		
	elif Input.is_action_pressed("move_left"):
		print('left')
		parent.direction.x = parent.direction.x - 1
		
	elif Input.is_action_pressed("move_back"):
		print('down')
		parent.direction.z = parent.direction.z + 1
		
	elif Input.is_action_pressed("move_forward"):
		print('up')
		parent.direction.z = parent.direction.z - 1
	else:
		parent.direction.z = 0
		parent.direction.x = 0
		return idle_state
	
	
	handleAnimation()
	
	
	# Prevent diagonal moving fast af
	if parent.direction != Vector3.ZERO:
		parent.direction = parent.direction.normalized()
	
	# Ground Velocity
	parent.target_velocity.x = parent.direction.x * parent.speed
	parent.target_velocity.z = parent.direction.z * parent.speed
	
	# Vertical Velocity
	if not parent.is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		parent.target_velocity.y = parent.target_velocity.y - (parent.fall_acceleration * delta)
	
	if parent.velocity.length() > 0:
		parent.velocity = parent.velocity.normalized() * parent.speed
	
	# Moving the Character
	parent.velocity = parent.target_velocity
	parent.move_and_slide()	
	return self	
