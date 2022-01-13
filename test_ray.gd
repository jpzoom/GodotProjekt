extends RayCast2D

var player = null
onready var so = get_node("Node2D/KinematicBody2D/RayCast2D")

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)

func set_player(p):
	player = p