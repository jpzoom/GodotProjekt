extends Area2D

signal destroyed(enemy_hit)

export var moveSpeed = 200
export var damage = 1

var direction : = Vector2()

func initialize(_direction: Vector2) -> void:
	direction = _direction
	randomize()
	
func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	set_as_toplevel(true)
	
func _process(delta: float) -> void:
	position += direction * moveSpeed * delta



