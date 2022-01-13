extends ColorRect

signal intro_fade_finished

func fade_in():
	$AnimationPlayer.play("Logo_fade_in")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("intro_fade_finished")
