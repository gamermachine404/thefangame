class_name minigame extends Control

#Abstract class for minigames

signal completed(name:String)
	#emit when minigame has been successfully completed

func nameMatches(value:String) -> bool:
	#returns true if this node's name matches the value
	
	return self.name == value
