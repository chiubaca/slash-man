extends State

@export
var idle_state: State

func enter() -> void:
	parent.animations.play("attack_down")

func process_physics(delta: float) -> State:
	if not parent.animations.is_playing():
		return idle_state
		
	return null
