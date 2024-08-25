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

var direction = Vector3.ZERO

var target_velocity = Vector3.ZERO


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
