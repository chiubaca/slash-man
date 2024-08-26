class_name Player
extends CharacterBody3D

signal hit

# How fast the player moves in meters per second
@export var speed = 24
# The downward acceleration while in the air, in meters per second squared.
@export var fall_acceleration = 75

@onready 
var animations = $AnimatedSprite3D
@onready 
var state_machine = $StateMachine
@onready 
var hit_box: Area3D = $HitBox
@onready 
var damage_indicator = $DamageIndicator

var direction = Vector3.ZERO

var target_velocity = Vector3.ZERO


func _ready() -> void:
	damage_indicator.visible = false
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)


func _on_hurt_box_area_entered(hitbox):
	damage_indicator.visible = true
	get_tree().create_timer(0.5).timeout.connect(func(): damage_indicator.visible = false)
	print('I got hurt!', hitbox)
	GlobalSignal.reduce_player_health.emit(10)
	pass # Replace with function body.

