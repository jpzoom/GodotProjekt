extends KinematicBody2D

export var speed = 0
const ACCELERATION = 100
const DECCELERATION = 50
const maxWalkSpeed = 250
const maxRunSpeed = 200

var look_direction = Vector2()
var move_direction = Vector2()
var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if input_direction:
		speed += 10 + ACCELERATION * delta
	else:
		speed = 0
	speed = clamp(speed, 0, maxWalkSpeed)
	
	velocity = input_direction * speed * delta
	move_and_collide(velocity)