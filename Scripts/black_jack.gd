extends minigame

var playernum
var systemnum
var solved = 0

func _ready():
	$Start.pressed.connect(start)

func start():
	solved = 0
	$GreatJob.visible = false
	systemnum = randi_range(11,20)
	playernum = 0
	for e in $Switches.get_children():
		e.value = randi_range(1,11)
		e.disabled = false
	update()
		
func update():
	$SysNum.text = var_to_str(systemnum)
	$PlaNum.text = var_to_str(playernum)
	if playernum > 21:
		reset()
		$Areusrs.visible = true
		await get_tree().create_timer(1).timeout
		$Areusrs.visible = false
	elif playernum > systemnum:
		for e in $Switches.get_children():
			e.disabled = true
		solved = 1
		$GreatJob.visible = true

func reset():
	playernum = 0
	for e in $Switches.get_children():
		e.disabled = false
	update()
