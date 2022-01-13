extends Control

signal tookDamage(health)
signal maxHP(maxHP)

func _on_HP_tookDamage(health):
	emit_signal('tookDamage', health)

