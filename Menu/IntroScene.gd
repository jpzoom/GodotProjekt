extends ColorRect

func _ready():
	$ColorRect.show()
	$ColorRect.fade_in()

func _on_ColorRect_intro_fade_finished():
	get_tree().change_scene("res://Menu/TitleScreen.tscn")

func _input(event):
	if Input.is_action_pressed("attack"):
		get_tree().change_scene("res://Menu/TitleScreen.tscn")