extends Control
var stage


func _ready():
	pass

func stealMouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func start():
	$Loading.visible = true
	stage = load("res://Assets/main.tscn").instantiate()
	self.get_parent().add_child(stage)
	stealMouse()
	$Loading.visible = false
	self.visible = false
	
func relay(msg):
	match msg:
		"Play":
			start()
		_:
			self.get_parent().relay(msg)
	
