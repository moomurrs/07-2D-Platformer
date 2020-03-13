extends Node2D


func _ready():
	pass


func _on_Save_pressed():
	# stage One completed, load stage two
	$"/root/GlobalVar".stageOne = true
