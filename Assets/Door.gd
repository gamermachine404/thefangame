extends MeshInstance3D
var opening = false
var openness = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("OpenForNow"):
		opening = !opening
	
	if openness < 2 and opening:
		openness += delta
		position.y += delta * 5
		$StaticBody3D.position.y += delta*5
	elif openness > 0 and not opening:
		openness -= delta
		position.y -= delta * 5
		$StaticBody3D.position.y -= delta*5
