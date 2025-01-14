extends CharacterBody3D

@export var speed = 14
@export var grav = 75
var targ = Vector3.ZERO
var dir = 0
var rot = 0
var endPos = Vector3.ZERO
var schmoove = false

func _physics_process(delta):
	
	if not schmoove:
		endPos = 0
		dir = 0
		if Input.is_action_just_pressed("MoveToTheForwards"):
			dir = 1
		if Input.is_action_just_pressed("MoveToTheBackwards"):
			dir = -1
		if Input.is_action_just_pressed("MoveToTheLeft"):
			rot = -1
		if Input.is_action_just_pressed("MoveToTheRight"):
			rot = 1
	else:
		pass
		#here you make move
		
	if dir != 0:
		endPos.x = (sin($Pivot.rotation.y) * 5 * dir) + position.x
		endPos.z = (cos($Pivot.rotation.y) * 5 * dir) + position.z
		#position = endPos
		schmoove = true

	targ.x = sin($Pivot.rotation.y) * speed * dir
	targ.z = cos($Pivot.rotation.y) * speed * dir
		
	$Pivot.rotate_y(rot*deg_to_rad(-45))
	if not is_on_floor():
		targ.y = targ.y - (grav*delta)
			
	#velocity = targ
	move_and_slide()

