extends Node2D


func _ready():
	#  auto focus on the start button first
	$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()
	
func _physics_process(delta):
	#if $MarginContainer/VBoxContainer/VBoxContainer/Start.is_hovered():
		#$MarginContainer/VBoxContainer/VBoxContainer/Start.grab_focus()
	pass

# start the game at stage one



func _on_Start_pressed():
	get_tree().change_scene("res://StageOne.tscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Load_pressed():
	var isStageOneDone = $"/root/GlobalVar".stageOne
	var isStageTwoDone = $"/root/GlobalVar".stageTwo
	
	if isStageOneDone and isStageTwoDone:
		get_tree().change_scene("res://StageOne.tscn")
	elif isStageOneDone:
		get_tree().change_scene("res://StageTwo.tscn")
	else:
		get_tree().change_scene("res://StageOne.tscn")
		
		
		
		
