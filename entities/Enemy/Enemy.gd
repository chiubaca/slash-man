extends CharacterBody3D


var mesh

@export var life = 100


func _ready():
	mesh = get_node('DamageInidicator')
	mesh.visible = false  

func hit_by_player():
	mesh.visible = true
	get_tree().create_timer(0.5).timeout.connect(func(): mesh.visible = false)
	$OwAudio.play()
	print('ow you hit me')
	life -= 1
	
	if(life == 0):
		GlobalSignal.hit_enemy.emit(10)
		get_tree().create_timer(0.2).timeout.connect(func(): queue_free())
		return 
		
	GlobalSignal.hit_enemy.emit(5)


func _on_hit_box_area_entered(area):
	print('enemy something went in me', area)
	pass # Replace with function body.
