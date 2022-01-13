extends Area2D

signal attackFinished
signal attackStarted

onready var animationPlayer = $AnimationPlayer

enum STATES {
	IDLE,
	ATTACK,
}
var currentState = STATES.IDLE
var timer

export(int) var damage = 1

func _ready():
	change_state(STATES.IDLE)
	timer = $AttackTimer
	timer.connect("timeout", self, "_onTimerTimeout")
	
func attack():
	change_state(STATES.ATTACK)

func change_state(new_state):
	currentState = new_state
	match currentState:
		STATES.IDLE:
			visible = false
			$Area2D/CollisionShape2D.disabled = true
	match new_state:
		STATES.ATTACK:
			visible = true
			$Area2D/CollisionShape2D.disabled = false
			$AnimationPlayer.play("attack")
			timer.start()
			emit_signal("attackStarted")

func _onTimerTimeout():
	change_state(STATES.IDLE)
	emit_signal("attackFinished")
