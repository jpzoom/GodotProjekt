extends ColorRect

signal fadeOut_finished

func fade_in():
	$AnimationPlayer.play("Fade_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fadeOut_finished")
