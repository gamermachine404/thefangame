extends Node3D

func _ready():
	pass
	
func relay(msg):
	match msg:
		"Quit":
			get_tree().quit()
		_:
			print(msg)