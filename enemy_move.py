extends KinematicBody2D

const MOVE_SPEED = 30

onready var raycast = $Node2D/RayCast2D
onready var noda = $Node2D
onready var enemy = $Sprite

var player = null

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	noda.rotation = atan2(vec_to_player.y, vec_to_player.x)
	# raycast.rotation = atan2(vec_to_player.y, vec_to_player.x)
	# raycast.set_cast_to(player.global_position - (raycast.global_position))
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if player.global_position.x < enemy.global_position.x:
		$Sprite.rotation_degrees = 90
	else:
		$Sprite.rotation_degrees = -90
		
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func kill():
	queue_free()

func set_player(p):
	player = p