extends Control
var stage


func _ready():
	pass

func stealMouse() -> void:
	#Function to set the mouse to captured (first person view, essentially)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func start():
	
	var pro_tips = getProTips()
	print("Pro Tip: " + pro_tips.pick_random())
	$Loading/ProTip.text = "Pro Tip\n\n" + pro_tips.pick_random()
	
	$Loading.visible = true #makes loading screen visible
	
	#This part looks simple, but there's actually a lot going on. The first part makes the script wait 0.017 seconds
	#because it is slightly more than the time required for a frame to process, which will allow to make the loading 
	#screen visible before load(). This is important because load() makes the whole program pause, similar 
	#to OS.delay_msec(), making it unable to do anything, including rendering frames. So, without that first bit,
	#the Loading screen wouldn't render before load() is called. After the stage is successfully loaded,
	#the program waits 3 seconds, because I said so.
	await get_tree().create_timer(0.017).timeout
	stage = load("res://Assets/main.tscn").instantiate()
	await get_tree().create_timer(3).timeout
	
	self.get_parent().add_child(stage)
	stealMouse()
	$Loading.visible = false
	self.visible = false
	
func getProTips() -> Array[String]:
	if not FileAccess.file_exists("res://RandomBullshit/ProTips.txt"):
		print("no pro tips?")
		return ["pro tips have failed to load ._."]
	
	var pro_tips_file = FileAccess.open("res://RandomBullshit/ProTips.txt", FileAccess.READ)
	var tips: Array[String]
		
	while pro_tips_file.get_position() < pro_tips_file.get_length():
		tips.append(pro_tips_file.get_line())
	
	return tips
	
func relay(msg):
	match msg:
		"Play":
			start()
		_:
			self.get_parent().relay(msg)
	
