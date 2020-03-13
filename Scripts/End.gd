extends Node2D


func _ready():
	$Label.text = "Final Score: " + str(get_node("/root/GlobalVar").stageOnePoints + get_node("/root/GlobalVar").stageTwoPoints)
	get_node("/root/GlobalVar").stageOnePoints = 0
	get_node("/root/GlobalVar").stageTwoPoints = 0


func _on_Back_pressed():
	var isStageOneDone = $"/root/GlobalVar".stageOne
	var isStageTwoDone = $"/root/GlobalVar".stageTwo
	
	if isStageOneDone and isStageTwoDone:
		get_tree().change_scene("res://StageOne.tscn")
	elif isStageOneDone and not isStageTwoDone:
		get_tree().change_scene("res://StageTwo.tscn")
	else:
		get_tree().change_scene("res://StageOne.tscn")


func _on_Title_pressed():
	$"/root/GlobalVar".stageOne = false
	$"/root/GlobalVar".stageTwo = false
	get_tree().change_scene("res://Scenes/Title Screen.tscn")
