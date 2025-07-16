extends Control

func _ready():
	if self.get_class() == "Button":
		self.pressed.connect(genericPress)
		
func genericPress():
	relay(self.name)

func relay(msg):
	self.get_parent().relay(msg)
