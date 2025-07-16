extends Node3D
#@export var Connected:Array[String] = []
@export var CN:Array[NodePath] = []

func _ready() -> void:
	print(CN[0].get_name(1))
	#for c in Connected:
		#CN.append(self.get_parent().find_child(c))
		#print(c)

func getConnection(num:int) -> Node3D:
	return get_node(CN[num])
