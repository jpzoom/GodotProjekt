extends Sprite

signal no_enemies
export (NodePath) var location


func _process(delta):
	if get_tree().has_group("enemies"):
		$AnimationPlayer.play("Portal_Twirl")


func _on_Area2D_body_entered(body):
	if body.has_method("change_state"):
		var pos = body.get_position()
		var point = get_node(location)
		body.global_position = point.global_position
		$Area2D/AudioStreamPlayer.play()