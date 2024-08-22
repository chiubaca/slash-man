extends CharacterBody3D


var mesh

@export var life = 2


func _ready():
	mesh = get_node('MeshInstance3D')
	mesh.visible = false  

func hit_by_player():
	mesh.visible = true
	get_tree().create_timer(0.5).timeout.connect(func(): mesh.visible = false)
	#$OwAudio.play()
	print('ow you hit me')
	life -= 1
	
	if(life == 0):
		GlobalSignal.hit_enemy.emit(10)
		get_tree().create_timer(0.2).timeout.connect(func(): queue_free())
		return 
		
	GlobalSignal.hit_enemy.emit(5)
