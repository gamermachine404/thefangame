extends Node3D

@export var Connected:Array[String] = []
var CN:Array = []

func _ready() -> void:
	for c in Connected:
		CN.append(self.get_parent().find_child(c))
		print(c)

func getCN():
	return CN
