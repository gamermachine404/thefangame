extends Node3D

var state = 0
var player
var monitor
var clock

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player = $UnpaidIntern
	monitor = $Monitor
	clock = $Clock
	
	clock.visible = false
	monitor.visible = false
	
	for e in get_tree().get_nodes_in_group("Cams"):
		monitor.find_child(e.name).pressed.connect(e.activate)
		
func _process(delta):
	if Input.is_action_just_pressed("OpenMonitor"):
		if state == 0:
			player.lookaroundallowed = false
			player.movementallowed = false
			clock.visible = true
			monitor.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			state = 1
		elif state == 1:
			player.lookaroundallowed = true
			player.movementallowed = true
			clock.visible = false
			monitor.visible = false
			player.camera.current = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			state = 0
