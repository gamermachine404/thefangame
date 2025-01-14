extends CharacterBody3D

@export var speed = 14
@export var grav = 75
#var targ = Vector3.ZERO
var dir = 0
var rot = 0
var endPos = Vector3.ZERO
var schmoove = false

func _physics_process(delta):
	
	rot = 0

	if not schmoove:
		dir = 0
		if Input.is_action_just_pressed("MoveToTheForwards"):
			dir = 1
		if Input.is_action_just_pressed("MoveToTheBackwards"):
			dir = -1
	#set values of dir to indicate transition direction
	else:
		pass

	if Input.is_action_just_pressed("MoveToTheLeft"):
		rot = -1
	if Input.is_action_just_pressed("MoveToTheRight"):
		rot = 1
	#set values of rot to indicate rotation direction
		
	if dir != 0:
		if not schmoove:
			endPos.x = (sin($Pivot.rotation.y) * 5 * dir) + position.x
			endPos.z = (cos($Pivot.rotation.y) * 5 * dir) + position.z
			schmoove = true
		#position = endPos
	#set value of end position and set shmoove to true to disable additional inputs

	#targ.x = sin($Pivot.rotation.y) * speed * dir
	#targ.z = cos($Pivot.rotation.y) * speed * dir
		
	$Pivot.rotate_y(rot * deg_to_rad(-90))
	if not is_on_floor():
		pass
		#targ.y = targ.y - (grav*delta)
	#functional rotation and non-functional gravity
		
	move_and_slide()

