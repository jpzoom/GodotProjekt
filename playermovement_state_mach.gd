extends KinematicBody2D

export var speed = 110.0
export var speedPercent = 0.65
export var animationTightness = 0.2
var currentSpeed = speed
var sideChangeSpeed = 16
var timer
#
var velocity = Vector2()

# weapon
var bullet = preload("res://Bullet.tscn")
export (float) var shootCooldown
var canShoot = true
var alive = true

onready var raycast = $RayPivot/RayCast2D
onready var rayPivot = $RayPivot

# anim vars
var getAnim
var anim = ""
var animNew = ""

# direction var
var direction = 0

# state machine
enum STATES {
	IDLE,
	WALK,
	ATTACK,
	STAGGER,
	DEAD
}
var state = null

var weapon

func _ready():
	weapon = $WeaponPivot/Weapon
	
	timer = $AttackTimer
	timer.connect("timeout", self, "_onTimerTimeout")
	
	add_to_group("player")
	change_state(STATES.IDLE)
	yield(get_tree(), "idle_frame")
	get_tree().call_group("enemies", "set_player", self)


func change_state(new_state):
	var iRight = Input.is_action_pressed('move_right')
	var iLeft = Input.is_action_pressed('move_left')
	var iUp = Input.is_action_pressed('move_up')
	var iDown = Input.is_action_pressed('move_down')
	
	match new_state:
		STATES.IDLE:
			speed = 120
			if direction == 180:
				anim = "idle_up"
				$WeaponPivot.rotation_degrees = 0
				$WeaponPivot.scale = Vector2(1, 1)
			if direction == 0:
				anim = "idle_down"
				$WeaponPivot.rotation_degrees = 180
				$WeaponPivot.scale = Vector2(1, 1)
			if direction == 90:
				anim = "idle_right"
				$WeaponPivot.rotation_degrees = 90
				$WeaponPivot.scale = Vector2(1, 1)
			if direction == -90:
				anim = "idle_right"
				$WeaponPivot.rotation_degrees = -90
				$WeaponPivot.scale = Vector2(-1, 1)
			# dijagonale
			if direction == 45 || direction == -45:
				anim = "idle_drdwn"
			if direction == 135 || direction == -135:
				anim = "idle_drup"
		
		STATES.WALK:
			speed = 120
			if iRight && !iLeft:
				anim = "walk_right"
				$Sprite.flip_h = false
				$WeaponPivot.rotation_degrees = 90
				$WeaponPivot.scale = Vector2(1, 1)
			if iLeft && !iRight:
				anim = "walk_right"
				$Sprite.flip_h = true
				$WeaponPivot.rotation_degrees = -90
				$WeaponPivot.scale = Vector2(-1, 1)
			if iUp:
				anim = "walk_up"
				$WeaponPivot.rotation_degrees = 0
				$WeaponPivot.scale = Vector2(1, 1)
				if iRight && !iLeft:
					$Sprite.flip_h = false;
					anim = "walk_diagonally_up_right"
				if Input.is_action_pressed('move_left') && !iRight:
					$Sprite.flip_h = true;
					anim = "walk_diagonally_up_right"
			if iDown:
				anim = "walk_down"
				$WeaponPivot.rotation_degrees = 180
				$WeaponPivot.scale = Vector2(1, 1)
				if iRight && !iLeft:
					$Sprite.flip_h = false;
					anim = "walk_diagonally_down_right"
				if iLeft && !iRight:
					$Sprite.flip_h = true;
					anim = "walk_diagonally_down_right"
		
		STATES.ATTACK:
			speed = 0
			sideChangeSpeed = 0
			weapon.attack()
			$AttackTimer.start()
				
		STATES.STAGGER:
			$Sprite/EffectsAnimationPlayer.play("Damage_anim")

		STATES.DEAD:
			speed = 0
			$Death.play()
	state = new_state

func _input(event):
	if event.is_action_pressed("attack"):
		change_state(STATES.ATTACK)

func _physics_process(delta):
	print()
	var iRight = Input.is_action_pressed('move_right')
	var iLeft = Input.is_action_pressed('move_left')
	var iUp = Input.is_action_pressed('move_up')
	var iDown = Input.is_action_pressed('move_down')
	
	# diagonale
	var speedDiag = speed * speedPercent
	
	#ray = get_node("RayCast2D")
	getAnim = get_node("Sprite/AnimationPlayer")
	
	# velocity = Vector2()
	velocity = move_and_slide(velocity)
	
	var movex = 0
	var movey = 0
	
	# walk state
	if iRight:
		movex += 1
		direction = 90
	if iLeft:
		movex -= 1
		direction = -90
	if iUp:
		movey -= 1
		direction = 180
		if iLeft:
			direction = -135
		if iRight:
			direction = 135
	if iDown:
		movey += 1
		direction = 0
		if iLeft:
			direction = -45
		if iRight:
			direction = 45
		
	movex *= currentSpeed
	movey *= currentSpeed
	
	# diagonal speed fix
	if iUp || iDown:
		currentSpeed = speed
		if iRight || iLeft:
			currentSpeed = speedDiag
	elif iLeft:
		currentSpeed = speed
	elif iRight:
		currentSpeed = speed
	
	if $AttackTimer.is_stopped():
		if abs(velocity.x) > sideChangeSpeed || abs(velocity.y) > sideChangeSpeed:
			change_state(STATES.WALK)
		else:
			change_state(STATES.IDLE)
	
	if anim != animNew:
		animNew = anim
		getAnim.play(anim)
	
	# velocity = velocity.normalized() * speed * delta # bez momentuma
	velocity.x = lerp(velocity.x, movex*1.5, animationTightness)
	velocity.y = lerp(velocity.y, movey*1.5, animationTightness)

	
func _onTimerTimeout():
	$AttackTimer.stop()
	sideChangeSpeed = 16

func _on_Weapon_attackFinished():
	sideChangeSpeed = 16

func _on_HP_tookDamage(newHealth):
	if newHealth == 0:
		change_state(STATES.DEAD)
	else:
		change_state(STATES.STAGGER)

# sprječava kontinuiranu animaciju
var staggering = false
func _on_EffectsAnimationPlayer_animation_started(anim_name):
	staggering = true
func _on_EffectsAnimationPlayer_animation_finished(anim_name):
	staggering = false

# da li je neprijatelj ostetio lika
func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		$Sprite/AnimationPlayer/HP.takeDmg(1)

func _on_HP_noHealth():
	pass # Replace with function body.


func _on_Weapon_attackStarted():
	speed = 20
