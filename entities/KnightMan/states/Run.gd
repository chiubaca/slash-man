extends State

@export
var idle_state: State


func handle_animation() -> void:
	parent.animations.play()
	parent.animations.animation = get_animation_name_from_current_direction()

func get_animation_name_from_current_direction() -> String:
	var x = parent.direction.x
	var z = parent.direction.z
	
	if x > 0:
		if z > 0: return "run_down_right"
		elif z < 0: return "run_up_right"
		else: return "run_right"
	elif x < 0:
		if z > 0: return "run_down_left"
		elif z < 0: return "run_up_left"
		else: return "run_left"
	else:
		if z > 0: return "run_down"
		else: return "run_up"

# set directions based on inputs 
func set_direction_from_inputs() -> void:
	
	parent.direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		parent.direction.x += 1
	elif Input.is_action_pressed("move_left"):
		parent.direction.x -= 1
	
	if Input.is_action_pressed("move_back"):
		parent.direction.z += 1
	elif Input.is_action_pressed("move_forward"):
		parent.direction.z -= 1
	
	parent.direction = parent.direction.normalized()

func apply_movement(delta: float) -> void:
	# Ground Velocity
	parent.target_velocity.x = parent.direction.x * parent.speed
	parent.target_velocity.z = parent.direction.z * parent.speed
	
	# Vertical Velocity
	if not parent.is_on_floor():
		parent.target_velocity.y -= parent.fall_acceleration * delta
	
	parent.velocity = parent.target_velocity
	parent.move_and_slide()

func process_physics(delta: float) -> State:

	set_direction_from_inputs()
	
	if parent.direction == Vector3.ZERO:
		return idle_state

	handle_animation()
	
	apply_movement(delta)
	
	return self
