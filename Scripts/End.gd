extends Node2D


func _ready():
	$Label.text = "Final Score: " + str(get_node("/root/GlobalVar").score)
