extends State

@export
var run_state: State

@export
var attack_state: State

func enter() -> void:
	parent.animations.play('idle')


func process_input(event: InputEvent)-> State:
	if event.is_action_pressed("move_right") or event.is_action_pressed("move_left") or event.is_action_pressed("move_back") or event.is_action_pressed("move_forward"): 
		return run_state
		
	if event.is_action_pressed("attack"):
		return attack_state
		
	return self 
	
