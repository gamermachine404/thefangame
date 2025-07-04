extends Button

var value:int
var topnode

func _ready():
	topnode = self.get_parent().get_parent()
	self.pressed.connect(activate)

func activate():
	self.disabled = true
	topnode.playernum += value
	topnode.update()
