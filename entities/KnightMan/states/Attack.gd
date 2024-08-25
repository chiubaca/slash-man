extends State

@export
var idle_state: State


func enter() -> void:
	
	print('hitbox',  parent.hit_box)
	parent.animations.play("attack_down")

func process_physics(delta: float) -> State:
	
	var enemies_hit = parent.hit_box.get_overlapping_bodies()
	for enemy in enemies_hit:
		if enemy.has_method("hit_by_player"):
			enemy.hit_by_player()
	
	if not parent.animations.is_playing():
		return idle_state
		
	return null
