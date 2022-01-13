extends Node

export (int) var xCoordinate
export (int) var yCoordinate
export (String) var roomName


func _init():
	var x = 400
	var y = 192
	var scene = load("res://Rooms/Room RB.tscn")
	print(roomName)
	var roomLocation = Vector2(x, y)
	var scene_instance = scene.instance()
	scene_instance.set_name("room")
	scene_instance.position = roomLocation
	add_child(scene_instance)