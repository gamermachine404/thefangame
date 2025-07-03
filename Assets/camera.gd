extends Node3D
var cam

func _ready():
	cam = $Brick/Camera3D

func activate():
	cam.current = true
