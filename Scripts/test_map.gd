extends Node3D

var state = "nothing"
var player
var monitor
var clock
var iicon
var iiconVisibility

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player = $UnpaidIntern
	monitor = $Monitor
	clock = $Clock
	iicon = $InteractIcon
	
	clock.visible = false
	monitor.visible = false
	
	for e in get_tree().get_nodes_in_group("Cams"):
		monitor.find_child(e.name).pressed.connect(e.activate)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("OpenMonitor"):
		if state == "nothing":
			player.lookaroundallowed = false
			player.movementallowed = false
			clock.visible = true
			monitor.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			state = "cameras"
		elif state == "cameras":
			player.lookaroundallowed = true
			player.movementallowed = true
			clock.visible = false
			monitor.visible = false
			player.camera.make_current()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			state = "nothing"


	

func minigame(name):
	print(name)
	var blackjack = load("res://Assets/BlackJack.tscn").instantiate()
	self.add_child(blackjack)

func toggleIcon(value):
	iiconVisibility = value
	iicon.visible = iiconVisibility
