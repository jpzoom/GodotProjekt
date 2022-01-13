extends Node2D


func _on_Button_pressed():
	get_tree().change_scene('res://Menu/TitleScreen.tscn')
	
func _ready():
	if get_tree().has_group("enemies"):
		$Portal/AnimationPlayer.play("Twirl_portal")