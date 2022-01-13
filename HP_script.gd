extends Node

signal tookDamage
signal noHealth
signal maxHealth

var invincible = false

var currentHP = 0
export(int) var maxHP = 4

func _ready():
	currentHP = maxHP
	emit_signal("maxHealth", maxHP)
	
func resetInvincible():
	invincible = false

func takeDmg(dmg):
	if (invincible == false):
		currentHP -= dmg
		invincible = true
		if currentHP <= 0:
			currentHP = 0
			emit_signal("noHealth")
	emit_signal("tookDamage", currentHP)

func _on_EffectsAnimationPlayer_animation_finished(anim_name):
	resetInvincible()
