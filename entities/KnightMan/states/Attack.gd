extends State

@export
var idle_state: State


var growth_speed = 3.5  # Units per second
var max_scale = 5.0     # Maximum scale on Z-axis


func enter() -> void:
	print('hitbox',  parent.hit_box)
	parent.animations.play("attack_down")


func process_physics(delta: float) -> State:
	# Increase the Z scale
	var new_scale = parent.hit_box.scale
	new_scale.z += growth_speed * delta
	# Clamp the Z scale to the maximum value
	#new_scale.z = min(new_scale.z, max_scale)
	parent.hit_box.scale = new_scale
	
	var enemies_hit = parent.hit_box.get_overlapping_bodies()
	for enemy in enemies_hit:
		if enemy.has_method("hit_by_player"):
			enemy.hit_by_player()
			
	
	if not parent.animations.is_playing():
		return idle_state
		
	return null


func exit() -> void:
	parent.hit_box.scale.z = 0
