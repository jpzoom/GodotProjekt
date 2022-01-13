extends Node2D

func loadPlayer():
	var pc = load("res://Player.tscn")
	var scene_instance = pc.instance()
	scene_instance.set_name("pc")
	add_child(scene_instance)


func _ready():
	loadPlayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
