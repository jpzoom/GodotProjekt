extends Node2D

func _on_KinematicBody2D_enemyHasDied():
	queue_free()
