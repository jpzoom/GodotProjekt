extends Sprite

func _on_Area2D_area_entered(area):
	if area.is_in_group("weapon"):
		$AudioStreamPlayer2D.play()
		print("HIT THE SWORD ON THE TEST STUFF")
