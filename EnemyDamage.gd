extends Area2D

signal takeEnemyDmg

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("takeEnemyDmg", 1)
