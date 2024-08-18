extends CharacterBody3D


var mesh

func _ready():
	mesh = get_node('MeshInstance3D')
	mesh.visible = false


func hit_by_player():
	mesh.visible = true
	get_tree().create_timer(0.5).timeout.connect(func(): mesh.visible = false)
	print('ow you hit me')
	
	
