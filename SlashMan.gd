extends CharacterBody3D

signal hit

# How fast the player moves in meters per second
@export var speed = 24
# The downward acceleration while in the air, in meters per second squared.
@export var fall_acceleration = 75
# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20
# Vertical impulse applied to the character upon bouncing over a mob
# in meters per second.
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO

func handleAnimation(dirX, dirY):
	if dirX == 0 and dirY == 0:
		print("Idle")
		return

	if dirX > 0:
		if dirY > 0:
			print("Moving Down-Right")
			$AnimatedSprite3D.animation = "run_up_right"
		elif dirY < 0:
			print("Moving Up-Right")
		else:
			print("Moving Right")
			$AnimatedSprite3D.animation = "run_right"
	elif dirX < 0:
		if dirY > 0:
			print("Moving Down-Left")
		elif dirY < 0:
			print("Moving Up-Left")
		else:
			print("Moving Left")
			$AnimatedSprite3D.animation = "run_left"
	else:
		if dirY > 0:
			print("Moving Down")
			$AnimatedSprite3D.animation = "run_down"
		else:
			print("Moving Up")
			$AnimatedSprite3D.animation = "run_up"


func _physics_process(delta):
	# We create a local variable to store the input direction
	var direction = Vector3.ZERO

	
	# We check for each move input and update the direction accordingly
	if Input.is_action_pressed("move_right"):
		#print('right')
		direction.x = direction.x + 1
		
	if Input.is_action_pressed("move_left"):
		#print('left')
		direction.x = direction.x - 1
		
	if Input.is_action_pressed("move_back"):
		#print('down')
		direction.z = direction.z + 1
		
	if Input.is_action_pressed("move_forward"):
		#print('up')
		direction.z = direction.z - 1
		
	

	#print(direction.x, direction.z)
	handleAnimation(direction.x, direction.z)	
		


	# Prevent diagonal moving fast af
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#$Pivot.look_at(position + direction, Vector3.UP)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)


	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite3D.play()
	else:
		$AnimatedSprite3D.stop()

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	#$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse

