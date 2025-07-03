extends Control

var time = 0. #variiable to keep track of elapsed time
var delay = 1 #variable to determine delay between time progression
var display #variable to display current time

func _ready():
	display = $TimeDisplay
	update_display()

func _process(delta: float):
	time += delta
	update_display()

func update_display():
	display.text = str(floor(time))
