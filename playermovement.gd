extends KinematicBody2D

export var speed = 110.0
export var speedPercent = 0.65
export var speedModifier = 1 # za kasnije
export var animationTightness = 0.2

var currentSpeed = speed
#
const sideChangeSpeed = 16
#
var velocity = Vector2()
# var ray
var getAnim
var anim = ""
var animNew = ""

var dir = 0

func get_input():
	
	# ray = get_node("RayCast2D")
	
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
	
	if iRight:
		movex += 1
		#velocity.x += 1
		dir = 90
	if iLeft:
		movex -= 1
		#velocity.x += -1
		dir = 90
	if iUp:
		movey -= 1
		#velocity.y -= 1
		dir = 180
	if iDown:
		movey += 1
		#velocity.y += 1
		dir = 0
	
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
	
	
	# velocity = velocity.normalized() * speed * delta # bez momentuma
	velocity.x = lerp(velocity.x, movex*1.5, animationTightness)
	velocity.y = lerp(velocity.y, movey*1.5, animationTightness)

	
# animacije

func animation():
	if abs(velocity.x) > sideChangeSpeed || abs(velocity.y) > sideChangeSpeed:
		if Input.is_action_pressed('move_left'):
			anim = "walk_right"
			$Sprite.flip_h = true
			
		if Input.is_action_pressed('move_right'):
			anim = "walk_right"
			$Sprite.flip_h = false
			
		if Input.is_action_pressed('move_down'):
			anim = "walk_down"
			if Input.is_action_pressed('move_right'):
				$Sprite.flip_h = false;
				anim = "walk_diagonally_down_right"
				dir = 45
			if Input.is_action_pressed('move_left'):
				$Sprite.flip_h = true;
				anim = "walk_diagonally_down_right"
				dir = 45
				
		if Input.is_action_pressed('move_up'):
			anim = "walk_up"
			if Input.is_action_pressed('move_right'):
				$Sprite.flip_h = false;
				anim = "walk_diagonally_up_right"
				dir = 135
			if Input.is_action_pressed('move_left'):
				$Sprite.flip_h = true;
				anim = "walk_diagonally_up_right"
				dir = 135
	else:
			
		if dir == 180:
			anim = "idle_up"
		if dir == 0:
			anim = "idle_down"
		if dir == 90:
			anim = "idle_right"
		# dijagonale
		if dir == 45:
			anim = "idle_drdwn"
		if dir == 135:
			anim = "idle_drup"
	
	# print(ray.rotation)
	
	if anim != animNew:
		animNew = anim
		getAnim.play(anim)

func _physics_process(delta):
	get_input()
	animation()