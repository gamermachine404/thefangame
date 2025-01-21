extends CharacterBody3D

@export var speed = 10
@export var grav = 75
@export var tilesize = 5 #Determines the size of a tile moved in one movement
#var targ = Vector3.ZERO
var dir = 0 #Used to determine if player is moving backwards/forwards
var rot = 0
var endPos = Vector3.ZERO
var schmoove = Vector3.ZERO
var sens = 0.01 #Mouse sensitivity

var travelTo = Vector3.ZERO
var rotAmount

func _ready() -> void:
	endPos = position
	stealMouse()

func stealMouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#removes the mouse from existence to make player able to look around

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$Pivot.rotate_y(-event.relative.x * sens)
		$Pivot/Camera3D.rotate_x(event.relative.y * sens)
		$Pivot/Camera3D.rotation.x = clamp($Pivot/Camera3D.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		#Rotate the body of the player in y and camera in x in function of x y movement of mouse.
		#Use clamp function to make sure the camera's X rotation value stays within a set range to prevent it from flipping over/under

func _physics_process(delta):
	#print("sine")
	#print(sin($Pivot.rotation.y))
	#print("cosine")
	#print(cos($Pivot.rotation.y))

	var sine = sin($Pivot.rotation.y)
	var cosine = cos($Pivot.rotation.y)

	rot = 0
	dir = 0

	if endPos == position:

		if Input.is_action_just_pressed("MoveToTheForwards"):
			dir = 1
		elif Input.is_action_just_pressed("MoveToTheBackwards"):
			dir = -1
		elif Input.is_action_just_pressed("MoveToTheLeft"):
			rot = -1
		elif Input.is_action_just_pressed("MoveToTheRight"):
			rot = 1
	#set values of dir or rot to indicate transition direction

	
	if rot+dir != 0:
		if abs(sine) >= abs(cosine):
			if sine > 0:
				rotAmount = deg_to_rad(90)
			else:
				rotAmount = deg_to_rad(270)
		else:
			if cosine > 0:
				rotAmount = 0
			else:
				rotAmount = deg_to_rad(180)
		#Basically determines the general direction the player is looking in for movement
		if dir !=0:
			endPos.x = (sin(rotAmount) * tilesize * dir) + position.x
			endPos.z = (cos(rotAmount) * tilesize * dir) + position.z
		else:
			endPos.x = (-cos(rotAmount) * tilesize * rot) + position.x
			endPos.z = (sin(rotAmount) * tilesize * rot) + position.z
		schmoove = (endPos - position)*speed

		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(position, endPos)
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)

		if result.has("collider"):
			endPos = position
		#Using the rotAmount (the general direction), determines which coordinates to change, and makes that the endPos
		#Makes schmoove's value a vector FROM position TO endPos, and multiplies that by speed. We will use this vector to have smooth movement.

	if endPos != position:
		var diff = endPos - position
		print(abs(diff.length()))
		if abs(diff.length()) < (schmoove*delta).length():
			position = endPos
			#This section checks if the vector FROM current position TO endPos is smaller than schmoove, in which case it will directly set the player's position to that endPos
			#This is important in order to avoid overshoots and make sure the movement remains grid-based
		else:
			position = position + (schmoove*delta)
			#Here we simply increment the position by schmoove times delta to move the player

	#targ.x = sin($Pivot.rotation.y) * speed * dir
	#targ.z = cos($Pivot.rotation.y) * speed * dir
		
	if not is_on_floor():
		pass
		#targ.y = targ.y - (grav*delta)
	#functional rotation and non-functional gravity
		
	move_and_slide()
