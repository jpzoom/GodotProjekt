extends HBoxContainer

var maxValue
var currentHealth = 0

func initialize(maximum):
	maxValue = maximum
	$TextureProgress.max_value = maximum

func _on_Sucelje_tookDamage(health):
	animateValue(currentHealth, health)
	currentHealth = health
	# $TextureProgress.value = health

func animateValue(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()
