extends Node2D

var pauseCheck
signal no_enemies_left
var deathCheck = 0

func _ready():
	get_tree().paused = true
	$FadeCanvas/FadeOut.show()
	$FadeCanvas/FadeOut/AnimationPlayer.play("Fade_out")
	print("Started game")
	
func _on_HP_noHealth():
	deathCheck = 1
	get_tree().paused = true
	$CanvasLayer2/FadeIn.show()
	$CanvasLayer2/FadeIn.fade_in()

func _on_Death_finished():
	get_tree().change_scene("res://Menu/GameOverTitle.tscn")

func _on_Game__Goblin_boy_no_enemies_left():
	print("Enemy checker works")

func _on_FadeIn_fade_finished():
	if deathCheck == 1:
		get_tree().change_scene("res://Menu/GameOverTitle.tscn")
	else:
		get_tree().change_scene("res://Menu/GameWon.tscn")

func _on_FadeOut_fadeOut_finished():
	if get_tree().paused == true:
		get_tree().paused = false

func _process(delta):
	var enemies = get_tree().get_nodes_in_group("enemy")
	var enemyCounter = enemies.size()
	if enemyCounter == 0:
		$CanvasLayer2/FadeIn.show()
		$CanvasLayer2/FadeIn/AnimationPlayer.play("FadeIn")
