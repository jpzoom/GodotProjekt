extends Node2D

func _init():
	var scene = load("res://Player.tscn")
	var playerLocation = Vector2(240, 165)
	var scene_instance = scene.instance()
	scene_instance.set_name("player")
	scene_instance.position = playerLocation
	add_child(scene_instance)