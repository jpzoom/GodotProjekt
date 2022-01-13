extends Node
class_name RoomClass

export var gridPosition = Vector2()
export (int )var type
export (bool) var top
export (bool) var bottom
export (bool) var left
export (bool) var right

func _init(_gridPosition, _type):
	gridPosition = _gridPosition
	type = _type
