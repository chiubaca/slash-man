extends CharacterBody3D

@onready
var damage_indicator = $'DamageInidicator'

@export var life = 5


func _ready():
	damage_indicator.visible = false  

func hit_by_player():
	damage_indicator.visible = true
	get_tree().create_timer(0.5).timeout.connect(func(): damage_indicator.visible = false)
	$OwAudio.play()
	print('ow you hit me')
	life -= 1
	
	if(life == 0):
		GlobalSignal.add_points.emit(10)
		get_tree().create_timer(0.2).timeout.connect(func(): queue_free())
		return 
		
	GlobalSignal.add_points.emit(5)


func _on_hurt_box_area_entered(area):
	print('enemy was hit!', area)
	hit_by_player()
	pass # Replace with function body.
