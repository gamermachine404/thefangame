class_name interactible extends Node3D
const test_map = preload("res://Scripts/test_map.gd")

#An abstract class for interactibles.

#Variables
	#interactensity (float): lower values make the player have to be closer and face more towards the object to interact with it.
	#
	#player (unpaid_intern): gets defined as the player object.
	#
	#map (test_map): gets defined as the map object which contains this.
	#
	#iicon (Node): gets defined as the interaction icon object. To do: add support for different interaction icons.
	#
	#inRange (bool): a value that gets toggled to true if player is in a position where they can interact
	#
	#enabled (bool): set to false to make uninteractible and disable interactibility checks.

#Functions
	#actualReady() gets called when this object's parent has gone through _ready(). Overwrite to
	#set variables to different shit.
	#
	#interacted() gets called when the object is interacted with. Overwrite to do stuff.

@export var interactensity:float
var enabled = true
var inRange = false
var map:test_map
var player
var iicon

func _ready():
	get_parent().ready.connect(actualReady)
	map = get_parent()
	
	#alright so basically the way _ready() works is that before a node's _ready() is called, its children's 
	#_ready() functions are called and completed first. So, in order to get the correct value for the parent's
	#player value, which will only have a value once its _ready has completed, we wait for its ready signal,
	#which will be emitted once its _ready function has completed, and connect it to another function which
	#will set the value. Im sure there's a better way to do this, but if it works, it works. -C
	
func actualReady():
	player = map.player
	iicon = map.iicon
	
func _process(delta):
	if enabled:
		var angl = $MeshInstance3D/Sprite3D.global_position.direction_to(self.global_position).dot(player.getLookingVector()/player.global_position.distance_to(self.global_position))
		if interactensity < angl:
			if not inRange:
				inRange = true
				map.toggleIcon(true)
		elif inRange:
			inRange = false
			map.toggleIcon(false)
		#This piece of code is an absolute atrocity and there's probably a thousand ways to make it better.
		#But anyways, basically this piece of code makes a vector of where the player is looking,
		#and scales that vector inversely proportionally to the distance between the player and the box.
		#it then does a dot product with a vector of where the box is "looking" and if the result is
		#big enough we can be reasonably certain that the player is looking at the box.
		#While this isnt exactly a bad way of determining if the player is looking at the box or not,
		#the way I used to obtain the vectors is lazy and there's probably a more complex, but less lazy way
		#to find them. Also this is being called every frame, so it's not the most efficient thing.
		#we should probably add something that makes this code not run if the player isn't close enough to the box
		#and/or if the box isn't on screen. Or maybe dont run it unless the player is on the tile where the
		#interactible is. Like I said, there's probably a thousand ways of making this better.

func _unhandled_input(event: InputEvent) -> void:
	if inRange and Input.is_action_just_pressed("Interact"):
		interacted()
		
func interacted():
	pass
