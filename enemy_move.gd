extends KinematicBody2D

const MOVE_SPEED = 30

signal enemyHasDied

onready var raycast = $Sprite/Node2D/RayCast2D
onready var enemy = $Sprite
onready var animHead = $Sprite/AnimationPlayer
onready var animLegs = $Sprite2/AnimationPlayer

var playerProximityCheck = 0

var player = null

func _ready():
	add_to_group("enemies")
	

func _physics_process(delta):
	print(playerProximityCheck)
	if player == null:
		return
	
	if playerProximityCheck == 1:
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		$Sprite2/AnimationPlayer.play("Enemy_walk")
		move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
	else:
		pass
	
	if player.global_position.x < enemy.global_position.x:
		$Sprite.rotation_degrees = 20
	else:
		$Sprite.rotation_degrees = -20

func kill():
	queue_free()

func set_player(p):
	player = p

func _on_Area2D_area_entered(area):
	if area.is_in_group("weapon") && area.visible == true:
		$Sprite/AnimationPlayer/HP.takeDmg(2)
		$Hit.play()

func _on_HP_tookDamage(newHealth):
	if newHealth == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.z_index = 200
		print($Area2D/CollisionShape2D.z_index)
		$Died.play()
		animHead.play("Enemy_death")
		animLegs.play("Enemy_died_l")
	else:
		$Sprite/AnimationPlayer.play("Damage_enmy")

func _on_Died_finished(): # zvuk
	emit_signal("enemyHasDied")
	

func _on_PlayerCheck_body_entered(body):
	if body.is_in_group("player"):
		playerProximityCheck = 1
