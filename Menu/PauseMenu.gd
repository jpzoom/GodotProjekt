extends Control

var isDead = false

func _input(event):
	if isDead == false:
		if event.is_action_pressed("pause_action"):
			var newPauseState = not get_tree().paused
			get_tree().paused = newPauseState
			visible = newPauseState
	else:
		pass



func _on_HP_noHealth():
	isDead = true
