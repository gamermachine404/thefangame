extends CharacterBody3D

const position_node = preload("res://Assets/position_node.gd")

@export var speed = 10
@export var grav = 75
@export var tilesize = 5 #Determines the size of a tile moved in one movement
#var targ = Vector3.ZERO
var dir = 0 #Used to determine if player is moving backwards/forwards
var rot = 0
var endPos = Vector3.ZERO
var schmoove = Vector3.ZERO
var sens = 0.01 #Mouse sensitivity

var testArray = [1,2,3,4]

var chosenNode:position_node

var travelTo = Vector3.ZERO
var rotAmount
var selectedNode:int = 0

func _ready() -> void:
	endPos = position
	chosenNode = self.get_parent().find_child("PositionNodes").find_child("1")
